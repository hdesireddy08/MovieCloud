public with sharing class MovieCloudController {
    @AuraEnabled
    public static ListMovie getMovies(Map<String, Object> parameters) {
        return MovieApi.getMovies(parameters);
    }

    @AuraEnabled
    public static ListGenre getGenres(String language) {
        return MovieApi.getGenres(language);
    }
}