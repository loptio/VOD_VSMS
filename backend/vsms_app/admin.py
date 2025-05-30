from django.contrib import admin
from .models import (
    Movie, Member, Actor, Director, Company, GenreType,
    MemberStatusType, Purchase, Download, HasGenre, ActIn, DirectMovie
)


@admin.register(Movie)
class MovieAdmin(admin.ModelAdmin):
    list_display = ['movie_id', 'title', 'release_date', 'charge_per_download', 'company_name']
    list_filter = ['release_date', 'company_name']
    search_fields = ['title']
    ordering = ['-release_date']


@admin.register(Member)
class MemberAdmin(admin.ModelAdmin):
    list_display = ['member_id', 'name', 'email', 'balance', 'registration_date', 'status']
    list_filter = ['status', 'registration_date']
    search_fields = ['name', 'email']
    ordering = ['-registration_date']


@admin.register(Actor)
class ActorAdmin(admin.ModelAdmin):
    list_display = ['actor_name', 'birth_date', 'nationality', 'gender']
    list_filter = ['gender', 'nationality']
    search_fields = ['actor_name']
    ordering = ['actor_name']


@admin.register(Director)
class DirectorAdmin(admin.ModelAdmin):
    list_display = ['director_name', 'birth_date', 'gender']
    list_filter = ['gender']
    search_fields = ['director_name']
    ordering = ['director_name']


@admin.register(Company)
class CompanyAdmin(admin.ModelAdmin):
    list_display = ['company_name', 'address']
    search_fields = ['company_name']
    ordering = ['company_name']


@admin.register(GenreType)
class GenreTypeAdmin(admin.ModelAdmin):
    list_display = ['genre_name']
    search_fields = ['genre_name']
    ordering = ['genre_name']


@admin.register(MemberStatusType)
class MemberStatusTypeAdmin(admin.ModelAdmin):
    list_display = ['status_id', 'status_name']
    ordering = ['status_id']


@admin.register(Purchase)
class PurchaseAdmin(admin.ModelAdmin):
    list_display = ['purchase_id', 'member', 'movie', 'purchase_date', 'amount']
    list_filter = ['purchase_date']
    search_fields = ['member__name', 'movie__title']
    ordering = ['-purchase_date']


@admin.register(Download)
class DownloadAdmin(admin.ModelAdmin):
    list_display = ['download_id', 'member', 'movie', 'download_timestamp']
    list_filter = ['download_timestamp']
    search_fields = ['member__name', 'movie__title']
    ordering = ['-download_timestamp']