from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register(r'movies', views.MovieViewSet)
router.register(r'members', views.MemberViewSet)
router.register(r'purchases', views.PurchaseViewSet)
router.register(r'downloads', views.DownloadViewSet)
router.register(r'actors', views.ActorViewSet)
router.register(r'directors', views.DirectorViewSet)
router.register(r'companies', views.CompanyViewSet)
router.register(r'genres', views.GenreTypeViewSet)
router.register(r'member-status', views.MemberStatusTypeViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('sql-query/', views.execute_sql_query, name='execute_sql_query'),
]