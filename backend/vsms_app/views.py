from rest_framework import viewsets, status
from rest_framework.decorators import action, api_view
from rest_framework.response import Response
from django.db.models import Sum, Count, Q
from django.db import connection
from django.utils import timezone
from datetime import datetime, timedelta, date
from decimal import Decimal

from .models import (
    Movie, Member, Actor, Director, Company, GenreType,
    MemberStatusType, Purchase, Download, HasGenre, ActIn, DirectMovie
)
from .serializers import (
    MovieSerializer, MovieCreateSerializer, MemberSerializer,
    ActorSerializer, DirectorSerializer, CompanySerializer,
    GenreTypeSerializer, MemberStatusTypeSerializer,
    PurchaseSerializer, DownloadSerializer,
    MemberDownloadHistorySerializer, MovieStatsSerializer,
    MemberStatsSerializer
)


class MovieViewSet(viewsets.ModelViewSet):
    queryset = Movie.objects.all().select_related('company_name')
    serializer_class = MovieSerializer
    
    def get_serializer_class(self):
        if self.action == 'create':
            return MovieCreateSerializer
        return MovieSerializer
    
    @action(detail=False, methods=['get'])
    def search(self, request):
        """搜索电影"""
        title = request.query_params.get('title', '')
        genre = request.query_params.get('genre', '')
        actor = request.query_params.get('actor', '')
        director = request.query_params.get('director', '')
        year_from = request.query_params.get('year_from', '')
        year_to = request.query_params.get('year_to', '')
        
        # 使用基本查询集
        queryset = Movie.objects.all().select_related('company_name')
        
        if title:
            queryset = queryset.filter(title__icontains=title)
        
        if genre:
            movie_ids = HasGenre.objects.filter(
                genre_name__genre_name__icontains=genre
            ).values_list('movie_id', flat=True)
            queryset = queryset.filter(movie_id__in=movie_ids)
        
        if actor:
            movie_ids = ActIn.objects.filter(
                actor_name__icontains=actor
            ).values_list('movie_id', flat=True)
            queryset = queryset.filter(movie_id__in=movie_ids)
        
        if director:
            movie_ids = DirectMovie.objects.filter(
                director_name__icontains=director
            ).values_list('movie_id', flat=True)
            queryset = queryset.filter(movie_id__in=movie_ids)
        
        if year_from:
            queryset = queryset.filter(release_date__year__gte=year_from)
        
        if year_to:
            queryset = queryset.filter(release_date__year__lte=year_to)
        
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def benedict_cumberbatch_movies(self, request):
        """获取Benedict Cumberbatch在2005-2015年间的电影"""
        query = """
        SELECT m.title 
        FROM movies m 
        JOIN act_in ai ON m.movie_id = ai.movie_id 
        WHERE ai.actor_name = 'Benedict Cumberbatch' 
        AND YEAR(m.release_date) BETWEEN 2005 AND 2015 
        ORDER BY m.release_date DESC;
        """
        
        with connection.cursor() as cursor:
            cursor.execute(query)
            columns = [col[0] for col in cursor.description]
            results = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        return Response(results)
    
    @action(detail=False, methods=['get'])
    def top_downloaded_last_year(self, request):
        """获取去年下载频率最高的电影"""
        query = """
        SELECT m.title,count(d.download_id) as download_count 
        FROM movies m 
        JOIN download d ON m.movie_id = d.movie_id 
        WHERE YEAR(d.download_timestamp) = 2023 
        GROUP BY m.movie_id 
        ORDER BY download_count DESC 
        LIMIT 10;
        """
        
        with connection.cursor() as cursor:
            cursor.execute(query)
            columns = [col[0] for col in cursor.description]
            results = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        return Response(results)
    
    @action(detail=False, methods=['get'])
    def horror_sales_by_month(self, request):
        """获取恐怖电影销售高峰月份"""
        query = """
        WITH monthly_sales AS ( 
            SELECT 
                YEAR(p.purchase_date) AS year, 
                MONTH(p.purchase_date) AS month, 
                SUM(p.amount) AS total_sales 
            FROM movies m 
            JOIN purchase p ON m.movie_id = p.movie_id 
            LEFT JOIN has_genre h ON m.movie_id = h.movie_id 
            WHERE h.genre_name = 'Horror' 
            GROUP BY year, month 
        ), 
        ranked_sales AS ( 
            SELECT 
                year, 
                month, 
                total_sales, 
                RANK() OVER (PARTITION BY year ORDER BY total_sales DESC) as sales_rank 
            FROM monthly_sales 
        ) 
        SELECT 
            year, 
            month, 
            total_sales 
        FROM ranked_sales 
        WHERE sales_rank = 1 
        ORDER BY total_sales DESC;
        """
        
        with connection.cursor() as cursor:
            cursor.execute(query)
            columns = [col[0] for col in cursor.description]
            results = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        return Response(results)


class MemberViewSet(viewsets.ModelViewSet):
    queryset = Member.objects.select_related('status').all()
    serializer_class = MemberSerializer
    
    @action(detail=False, methods=['get'])
    def search(self, request):
        """搜索会员"""
        name = request.query_params.get('name', '')
        email = request.query_params.get('email', '')
        status_name = request.query_params.get('status', '')
        
        queryset = self.get_queryset()
        
        if name:
            queryset = queryset.filter(name__icontains=name)
        
        if email:
            queryset = queryset.filter(email__icontains=email)
        
        if status_name:
            queryset = queryset.filter(status__status_name=status_name)
        
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['get'])
    def download_history(self, request, pk=None):
        """获取会员下载历史"""
        member = self.get_object()
        serializer = MemberDownloadHistorySerializer(member)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def add_balance(self, request, pk=None):
        """为会员充值"""
        member = self.get_object()
        amount = request.data.get('amount', 0)
        
        try:
            amount = Decimal(str(amount))
            if amount <= 0:
                return Response(
                    {'error': '充值金额必须大于0'}, 
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            member.balance += amount
            member.save()
            
            serializer = self.get_serializer(member)
            return Response(serializer.data)
        
        except (ValueError, TypeError):
            return Response(
                {'error': '无效的金额格式'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
    
    @action(detail=False, methods=['get'])
    def john_smith_favorite_actress(self, request):
        """获取John Smith最喜欢的女演员"""
        query = """
        SELECT 
            ai.actor_name, 
            COUNT(d.download_id) as download_count 
        FROM members m 
        JOIN download d ON m.member_id = d.member_id 
        JOIN act_in ai ON d.movie_id = ai.movie_id 
        JOIN actors a ON ai.actor_name = a.actor_name AND ai.birth_date = a.birth_date 
        WHERE m.name = 'John Smith' AND a.gender = 'Female' 
        GROUP BY ai.actor_name 
        ORDER BY download_count DESC 
        LIMIT 1;
        """
        
        with connection.cursor() as cursor:
            cursor.execute(query)
            columns = [col[0] for col in cursor.description]
            results = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        return Response(results)
    
    @action(detail=False, methods=['get'])
    def top_customers(self, request):
        """获取最佳客户排行榜"""
        query = """
        SELECT 
            m.name, 
            SUM(p.amount) as total_spent, 
            COUNT(p.purchase_id) as purchase_count 
        FROM members m 
        JOIN purchase p ON m.member_id = p.member_id 
        GROUP BY m.member_id, m.name 
        ORDER BY total_spent DESC 
        LIMIT 10;
        """
        
        with connection.cursor() as cursor:
            cursor.execute(query)
            columns = [col[0] for col in cursor.description]
            results = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        return Response(results)


class PurchaseViewSet(viewsets.ModelViewSet):
    queryset = Purchase.objects.select_related('member', 'movie').all().order_by('-purchase_id')
    serializer_class = PurchaseSerializer
    
    def list(self, request, *args, **kwargs):
        """获取购买记录列表，支持搜索"""
        queryset = self.get_queryset()
        
        # 处理搜索参数
        member_name = request.query_params.get('member_name', '')
        movie_title = request.query_params.get('movie_title', '')
        date_from = request.query_params.get('date_from', '')
        date_to = request.query_params.get('date_to', '')
        
        if member_name:
            queryset = queryset.filter(member__name__icontains=member_name)
        
        if movie_title:
            queryset = queryset.filter(movie__title__icontains=movie_title)
        
        if date_from:
            try:
                from_date = timezone.make_aware(datetime.strptime(date_from, '%Y-%m-%d'))
                queryset = queryset.filter(purchase_date__gte=from_date)
            except ValueError as e:
                print(f"DEBUG: Error parsing date_from {date_from}: {e}")
                pass
        
        if date_to:
            try:
                to_date = timezone.make_aware(datetime.strptime(date_to + ' 23:59:59', '%Y-%m-%d %H:%M:%S'))
                queryset = queryset.filter(purchase_date__lte=to_date)
            except ValueError as e:
                print(f"DEBUG: Error parsing date_to {date_to}: {e}")
                pass
        
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    def create(self, request, *args, **kwargs):
        """创建购买记录并处理会员余额"""
        member_id = request.data.get('member')
        movie_id = request.data.get('movie')
        
        try:
            member = Member.objects.get(member_id=member_id)
            movie = Movie.objects.get(movie_id=movie_id)
            
            # 检查是否已经购买过该电影
            existing_purchase = Purchase.objects.filter(
                member=member,
                movie=movie
            ).first()
            
            if existing_purchase:
                return Response(
                    {'error': f'您已经购买过电影《{movie.title}》，无需重复购买'}, 
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            # 检查会员余额是否足够
            if member.balance < movie.charge_per_download:
                return Response(
                    {'error': '余额不足，请先充值'}, 
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            # 创建购买记录
            purchase = Purchase.objects.create(
                member=member,
                movie=movie,
                amount=movie.charge_per_download
            )
            
            # 扣除会员余额
            member.balance -= movie.charge_per_download
            member.save()
            
            # 创建下载记录
            Download.objects.create(
                member=member,
                movie=movie,
                download_timestamp=datetime.now(),
                purchase=purchase
            )
            
            serializer = self.get_serializer(purchase)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
            
        except Member.DoesNotExist:
            return Response(
                {'error': '会员不存在'}, 
                status=status.HTTP_404_NOT_FOUND
            )
        except Movie.DoesNotExist:
            return Response(
                {'error': '电影不存在'}, 
                status=status.HTTP_404_NOT_FOUND
            )
    
    @action(detail=False, methods=['get'])
    def by_date(self, request):
        """显示某日期的购买项目"""
        date = request.query_params.get('date')
        if not date:
            return Response(
                {'error': '请提供日期参数 (YYYY-MM-DD)'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        try:
            target_date = datetime.strptime(date, '%Y-%m-%d').date()
            purchases = Purchase.objects.filter(
                purchase_date__date=target_date
            ).select_related('member', 'movie')
            
            serializer = self.get_serializer(purchases, many=True)
            return Response(serializer.data)
            
        except ValueError:
            return Response(
                {'error': '无效的日期格式，请使用 YYYY-MM-DD'}, 
                status=status.HTTP_400_BAD_REQUEST
            )


class DownloadViewSet(viewsets.ModelViewSet):
    queryset = Download.objects.select_related('member', 'movie', 'purchase').all().order_by('-download_id')
    serializer_class = DownloadSerializer
    
    def list(self, request, *args, **kwargs):
        """获取下载记录列表，支持搜索"""
        queryset = self.get_queryset()
        
        # 处理搜索参数
        member_name = request.query_params.get('member_name', '')
        movie_title = request.query_params.get('movie_title', '')
        date_from = request.query_params.get('date_from', '')
        date_to = request.query_params.get('date_to', '')
        date = request.query_params.get('date', '')
        
        if member_name:
            queryset = queryset.filter(member__name__icontains=member_name)
        
        if movie_title:
            queryset = queryset.filter(movie__title__icontains=movie_title)
        
        if date:
            try:
                target_date = datetime.strptime(date, '%Y-%m-%d').date()
                queryset = queryset.filter(download_timestamp__date=target_date)
            except ValueError:
                pass
        
        if date_from:
            try:
                from_date = timezone.make_aware(datetime.strptime(date_from, '%Y-%m-%d'))
                queryset = queryset.filter(download_timestamp__gte=from_date)
            except ValueError:
                pass
        
        if date_to:
            try:
                to_date = timezone.make_aware(datetime.strptime(date_to + ' 23:59:59', '%Y-%m-%d %H:%M:%S'))
                queryset = queryset.filter(download_timestamp__lte=to_date)
            except ValueError:
                pass
        
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def by_date(self, request):
        """显示某日期的下载项目"""
        date = request.query_params.get('date')
        if not date:
            return Response(
                {'error': '请提供日期参数 (YYYY-MM-DD)'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        try:
            target_date = datetime.strptime(date, '%Y-%m-%d').date()
            downloads = Download.objects.filter(
                download_timestamp__date=target_date
            ).select_related('member', 'movie')
            
            serializer = self.get_serializer(downloads, many=True)
            return Response(serializer.data)
            
        except ValueError:
            return Response(
                {'error': '无效的日期格式，请使用 YYYY-MM-DD'}, 
                status=status.HTTP_400_BAD_REQUEST
            )


class ActorViewSet(viewsets.ModelViewSet):
    queryset = Actor.objects.all()
    serializer_class = ActorSerializer


class DirectorViewSet(viewsets.ModelViewSet):
    queryset = Director.objects.all()
    serializer_class = DirectorSerializer


class CompanyViewSet(viewsets.ModelViewSet):
    queryset = Company.objects.all()
    serializer_class = CompanySerializer


class GenreTypeViewSet(viewsets.ModelViewSet):
    queryset = GenreType.objects.all()
    serializer_class = GenreTypeSerializer


class MemberStatusTypeViewSet(viewsets.ModelViewSet):
    queryset = MemberStatusType.objects.all()
    serializer_class = MemberStatusTypeSerializer


@api_view(['POST'])
def execute_sql_query(request):
    """执行用户输入的SQL查询语句"""
    try:
        sql_query = request.data.get('sql', '').strip()
        
        if not sql_query:
            return Response(
                {'error': '请提供SQL查询语句'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # 安全检查：只允许SELECT语句和WITH语句（CTE）
        sql_upper = sql_query.upper().strip()
        if not (sql_upper.startswith('SELECT') or sql_upper.startswith('WITH')):
            return Response(
                {'error': '出于安全考虑，只允许执行SELECT查询语句和WITH查询语句'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # 检查是否包含危险关键词
        dangerous_keywords = ['DROP', 'DELETE', 'UPDATE', 'INSERT', 'ALTER', 'CREATE', 'TRUNCATE']
        for keyword in dangerous_keywords:
            if keyword in sql_upper:
                return Response(
                    {'error': f'出于安全考虑，不允许使用 {keyword} 语句'}, 
                    status=status.HTTP_400_BAD_REQUEST
                )
        
        with connection.cursor() as cursor:
            cursor.execute(sql_query)
            columns = [col[0] for col in cursor.description]
            results = cursor.fetchall()
            
        # 将结果转换为字典列表
        data = []
        for row in results:
            row_dict = {}
            for i, value in enumerate(row):
                # 处理特殊数据类型
                if isinstance(value, datetime):
                    row_dict[columns[i]] = value.strftime('%Y-%m-%d %H:%M:%S')
                elif isinstance(value, date):
                    row_dict[columns[i]] = value.strftime('%Y-%m-%d')
                elif isinstance(value, Decimal):
                    row_dict[columns[i]] = float(value)
                else:
                    row_dict[columns[i]] = value
            data.append(row_dict)
        
        return Response(data)
        
    except Exception as e:
        return Response(
            {'error': f'SQL执行错误: {str(e)}'}, 
            status=status.HTTP_400_BAD_REQUEST
        )