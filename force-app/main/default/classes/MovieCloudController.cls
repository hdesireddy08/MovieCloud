public with sharing class MovieCloudController {
   private static final String API_KEY='ebefb9c9b7bfbb144a0e42b22b148b8c';
   private static final String BEARER_TOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYmVmYjljOWI3YmZiYjE0NGEwZTQyYjIyYjE0OGI4YyIsInN1YiI6IjY1YzI0MTZjYWY4NWRlMDE4ODM3ZTc4MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ja43SSNQ-gUAfZi0or_1TONuiDGhfSZZ3qTYs6Jotr8';
   private static final String API_URL='https://api.themoviedb.org/3/movie/{0}'; 
   public String getTopRatedMovies(){
    String responseString = '';

        // Create an HTTP request
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(String.format(API_URL, new List<String>{'top_rated'}));
        request.setHeader('Authorization', 'Bearer ' + BEARER_TOKEN);

        // Send the HTTP request and get the response
        HttpResponse response = new Http().send(request);

        // Check if the request was successful
        if (response.getStatusCode() == 200) {
            // Parse the response body
            responseString = response.getBody();
        } else {
            // Handle error response
            responseString = 'Error: ' + response.getStatusCode() + ' - ' + response.getStatus();
        }

        return responseString;
   }
}