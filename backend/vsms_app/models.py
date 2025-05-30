from django.db import models
from django.core.validators import MinValueValidator
from decimal import Decimal


class Address(models.Model):
    address_id = models.AutoField(primary_key=True)
    country = models.CharField(max_length=100)
    state_province = models.CharField(max_length=100, blank=True, null=True)
    city = models.CharField(max_length=100)
    street = models.CharField(max_length=255)
    postal_code = models.CharField(max_length=20)
    house_number = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        db_table = 'address'
        managed = False

    def __str__(self):
        return f"{self.street}, {self.city}, {self.country}"


class Company(models.Model):
    company_name = models.CharField(max_length=255, primary_key=True)
    address = models.ForeignKey(Address, on_delete=models.SET_NULL, null=True, blank=True)

    class Meta:
        db_table = 'company'
        managed = False

    def __str__(self):
        return self.company_name


class GenreType(models.Model):
    genre_name = models.CharField(max_length=100, primary_key=True)

    class Meta:
        db_table = 'genre_type'
        managed = False

    def __str__(self):
        return self.genre_name


class Actor(models.Model):
    actor_name = models.CharField(max_length=255)
    birth_date = models.DateField()
    nationality = models.CharField(max_length=100, blank=True, null=True)
    gender = models.CharField(max_length=10, blank=True, null=True)

    class Meta:
        db_table = 'actors'
        unique_together = ('actor_name', 'birth_date')
        managed = False

    def __str__(self):
        return f"{self.actor_name} ({self.birth_date})"


class Director(models.Model):
    director_name = models.CharField(max_length=255)
    birth_date = models.DateField()
    gender = models.CharField(max_length=10, blank=True, null=True)

    class Meta:
        db_table = 'director'
        unique_together = ('director_name', 'birth_date')
        managed = False

    def __str__(self):
        return f"{self.director_name} ({self.birth_date})"


class MemberStatusType(models.Model):
    status_id = models.AutoField(primary_key=True, db_column='StatusID')
    status_name = models.CharField(max_length=50, unique=True, db_column='StatusName')

    class Meta:
        db_table = 'MemberStatusTypes'
        managed = False

    def __str__(self):
        return self.status_name


class Movie(models.Model):
    movie_id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    release_date = models.DateField(blank=True, null=True)
    charge_per_download = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        validators=[MinValueValidator(Decimal('0.00'))]
    )
    company_name = models.ForeignKey(
        Company, 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True,
        db_column='company_name',
        to_field='company_name'
    )

    class Meta:
        db_table = 'movies'
        managed = False

    def __str__(self):
        return self.title


class HasGenre(models.Model):
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    genre_name = models.ForeignKey(
        GenreType, 
        on_delete=models.CASCADE,
        db_column='genre_name',
        to_field='genre_name'
    )

    class Meta:
        db_table = 'has_genre'
        unique_together = ('movie', 'genre_name')
        managed = False


class ActIn(models.Model):
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    actor_name = models.CharField(max_length=255)
    birth_date = models.DateField()
    role = models.CharField(max_length=255)

    class Meta:
        db_table = 'act_in'
        unique_together = ('movie', 'actor_name', 'birth_date')
        managed = False


class DirectMovie(models.Model):
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    director_name = models.CharField(max_length=255)
    birth_date = models.DateField()

    class Meta:
        db_table = 'direct_movie'
        unique_together = ('movie', 'director_name', 'birth_date')
        managed = False


class Member(models.Model):
    member_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    balance = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        default=Decimal('0.00'),
        validators=[MinValueValidator(Decimal('0.00'))]
    )
    email = models.EmailField(max_length=255, unique=True)
    phone = models.CharField(max_length=50, blank=True, null=True)
    registration_date = models.DateField()
    status = models.ForeignKey(
        MemberStatusType, 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True,
        db_column='StatusID',
        default=1
    )

    class Meta:
        db_table = 'members'
        managed = False

    def __str__(self):
        return self.name


class Purchase(models.Model):
    purchase_id = models.AutoField(primary_key=True)
    member = models.ForeignKey(Member, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    purchase_date = models.DateTimeField(auto_now_add=True)
    amount = models.DecimalField(
        max_digits=10, 
        decimal_places=2,
        validators=[MinValueValidator(Decimal('0.00'))]
    )

    class Meta:
        db_table = 'purchase'
        managed = False

    def __str__(self):
        return f"{self.member.name} - {self.movie.title}"


class Download(models.Model):
    download_id = models.AutoField(primary_key=True)
    member = models.ForeignKey(Member, on_delete=models.SET_NULL, null=True, blank=True)
    movie = models.ForeignKey(Movie, on_delete=models.RESTRICT)
    download_timestamp = models.DateTimeField()
    purchase = models.ForeignKey(
        Purchase, 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True
    )

    class Meta:
        db_table = 'download'
        managed = False

    def __str__(self):
        return f"{self.member.name if self.member else 'Unknown'} - {self.movie.title}"