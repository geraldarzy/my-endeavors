# My Endeavors

My Endeavors is an app that allows a user to sign up and keep track of their journeys(endeavors). Whether that be a future endeavor or a past endeavor.


# Shotgun

Since it is not yet deployed, you can use `shotgun` to run this on your localhost. 

# Authentication

For password encryptions and authentication, were using the `BCrypt` gem.

# Database

For the database, we are now using `POSTGRESQL`. Not too long ago, this whole app was using `SQLITE3` but it has now been switched over.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

# Models
We have two models right now. They are the `endeavor` and `user` models. 
```
Endeavor.create(title: "title",description: "description", pic:"dropbox link", pic_caption:"pic_caption", status:"status")
```
`:pic` accepts a link from dropbox. The link has to be the shareable link that you get when you make your picture accesible to those with the link. 

The `endeavors_controller` takes this link and replaces the 'dl=0' at the end of the link and turns it into 'raw=1'. This is because the link dropbox provides is a link the picture surrounded by the dropbox website. If you turn the 'dl=0' into 'raw=1', the link directs you to just the image.

```User.create(username: "admin", password:"password")```

Bcrypt handles the salt and encryption part of storing the password. In the schema, the column is `password_digest` but we can access it with just `password`.

## License
[MIT](https://choosealicense.com/licenses/mit/)