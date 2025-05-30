from rest_framework import serializers
from .models import (
    Movie, Member, Actor, Director, Company, GenreType, 
    MemberStatusType, Purchase, Download, HasGenre, ActIn, DirectMovie
)


class GenreTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = GenreType
        fields = '__all__'


class CompanySerializer(serializers.ModelSerializer):
    class Meta:
        model = Company
        fields = '__all__'


class ActorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Actor
        fields = '__all__'


class DirectorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Director
        fields = '__all__'


class MemberStatusTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = MemberStatusType
        fields = '__all__'


class MovieSerializer(serializers.ModelSerializer):
    company_name_display = serializers.CharField(source='company_name.company_name', read_only=True)
    genres = serializers.SerializerMethodField()
    actors = serializers.SerializerMethodField()
    directors = serializers.SerializerMethodField()
    
    class Meta:
        model = Movie
        fields = '__all__'
    
    def get_genres(self, obj):
        genres = HasGenre.objects.filter(movie=obj).values_list('genre_name__genre_name', flat=True)
        return list(genres)
    
    def get_actors(self, obj):
        actors = ActIn.objects.filter(movie=obj).values('actor_name', 'birth_date', 'role')
        return list(actors)
    
    def get_directors(self, obj):
        directors = DirectMovie.objects.filter(movie=obj).values('director_name', 'birth_date')
        return list(directors)


class MovieCreateSerializer(serializers.ModelSerializer):
    genres = serializers.ListField(child=serializers.CharField(), write_only=True, required=False)
    actors = serializers.ListField(write_only=True, required=False)
    directors = serializers.ListField(write_only=True, required=False)
    
    class Meta:
        model = Movie
        fields = ['title', 'release_date', 'charge_per_download', 'company_name', 'genres', 'actors', 'directors']
    
    def create(self, validated_data):
        genres_data = validated_data.pop('genres', [])
        actors_data = validated_data.pop('actors', [])
        directors_data = validated_data.pop('directors', [])
        
        movie = Movie.objects.create(**validated_data)
        
        # Add genres
        for genre_name in genres_data:
            genre, _ = GenreType.objects.get_or_create(genre_name=genre_name)
            HasGenre.objects.create(movie=movie, genre_name=genre)
        
        # Add actors
        for actor_data in actors_data:
            ActIn.objects.create(
                movie=movie,
                actor_name=actor_data.get('actor_name'),
                birth_date=actor_data.get('birth_date'),
                role=actor_data.get('role', '')
            )
        
        # Add directors
        for director_data in directors_data:
            DirectMovie.objects.create(
                movie=movie,
                director_name=director_data.get('director_name'),
                birth_date=director_data.get('birth_date')
            )
        
        return movie


class MemberSerializer(serializers.ModelSerializer):
    status_display = serializers.CharField(source='status.status_name', read_only=True)
    registration_date = serializers.DateField(required=False)
    
    class Meta:
        model = Member
        fields = '__all__'
    
    def create(self, validated_data):
        # 如果沒有提供註冊日期，自動設置為今天
        if 'registration_date' not in validated_data:
            from django.utils import timezone
            validated_data['registration_date'] = timezone.now().date()
        return super().create(validated_data)
    
    def to_representation(self, instance):
        data = super().to_representation(instance)
        # 确保status字段返回正确的ID
        if instance.status:
            data['status'] = instance.status.status_id
        return data


class PurchaseSerializer(serializers.ModelSerializer):
    member_name = serializers.CharField(source='member.name', read_only=True)
    movie_title = serializers.CharField(source='movie.title', read_only=True)
    
    class Meta:
        model = Purchase
        fields = '__all__'


class DownloadSerializer(serializers.ModelSerializer):
    member_name = serializers.CharField(source='member.name', read_only=True)
    movie_title = serializers.CharField(source='movie.title', read_only=True)
    purchase_id = serializers.IntegerField(source='purchase.purchase_id', read_only=True, allow_null=True)
    amount = serializers.SerializerMethodField()
    
    class Meta:
        model = Download
        fields = '__all__'
    
    def get_amount(self, obj):
        if obj.purchase:
            return obj.purchase.amount
        elif obj.movie:
            return obj.movie.charge_per_download
        return 0


class MemberDownloadHistorySerializer(serializers.ModelSerializer):
    downloads = serializers.SerializerMethodField()
    total_spent = serializers.SerializerMethodField()
    status_display = serializers.CharField(source='status.status_name', read_only=True)
    
    class Meta:
        model = Member
        fields = ['member_id', 'name', 'email', 'balance', 'status_display', 'downloads', 'total_spent']
    
    def get_downloads(self, obj):
        downloads = Download.objects.filter(member=obj).select_related('movie', 'purchase')
        return [{
            'movie_title': download.movie.title,
            'download_date': download.download_timestamp,
            'amount': float(download.purchase.amount) if download.purchase else float(download.movie.charge_per_download) if download.movie else 0.0
        } for download in downloads]
    
    def get_total_spent(self, obj):
        total = Purchase.objects.filter(member=obj).aggregate(
            total=serializers.models.Sum('amount')
        )['total']
        return total or 0


class MovieStatsSerializer(serializers.Serializer):
    movie_id = serializers.IntegerField()
    title = serializers.CharField()
    download_count = serializers.IntegerField()
    total_revenue = serializers.DecimalField(max_digits=10, decimal_places=2)


class MemberStatsSerializer(serializers.Serializer):
    member_id = serializers.IntegerField()
    name = serializers.CharField()
    total_spent = serializers.DecimalField(max_digits=10, decimal_places=2)
    download_count = serializers.IntegerField()