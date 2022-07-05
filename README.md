
# My Popular Actors App

popular Explorer demo app which you can explore Popular Persons (actors, directors ..etc) and view details about them or save their photos.


## Tech Stack

**Client:**  Flutter , StateManagement using riverpod + state notifier , local storage using shared preferences 

**Server:** themoviedb.org api

## API Reference

baseUrl ="https://api.themoviedb.org/3/person"
#### Get all popular perosns per page

```http
  GET baseUrl/popular?$apiKey&en-US&$page
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get popular persons details

```http
  GET baseUrl/$person_id?$apiKey&language=en-US


```
| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
|`person_id`| `string` | **Required**. Id of person to fetch |

#### Get popular persons Images

```http
  GET baseUrl/$person_id/images?$apiKey&language=en-US
  
```

## features

- App displaying popular Persons from movies using web Service.
- App is responsive on mobile and tablet using flutter_screenutil.
- popular saved locally using shared_preferences and flutter_secure_storage
- Actions on downloading photos available.
- App is written with good clean architecture.



## Screenshots
<span><img src="https://github.com/omarezz332/myPopularActors/raw/master/assets/screenShots/popular_list1.jpeg" width="200" /></span>
<span><img src="https://github.com/omarezz332/myPopularActors/raw/master/assets/screenShots/popular_details.jpeg" width="200" /></span>
<span><img src="https://github.com/omarezz332/myPopularActors/raw/master/assets/screenShots/popular_details2.jpeg" width="200" /></span> 
<span><img src="https://github.com/omarezz332/myPopularActors/raw/master/assets/screenShots/image_download.jpeg" width="200" /></span> 
