from django.db import models

# Create your models here.

class User(models.Model):
    user_name     = models.CharField(max_length=20)
    user_email    = models.EmailField(unique=True)
    user_password = models.CharField(max_length=100)
    user_validate = models.BooleanField(default=False) # True하면 자동으로 인증완료 상태로 되버리기에 False로 지정
    