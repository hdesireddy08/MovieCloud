public with sharing class MovieCloudController {
    private static final String API_KEY = 'ebefb9c9b7bfbb144a0e42b22b148b8c';
    private static final String API_VERSION = '3';
    private static final String API_URL = 'https://api.themoviedb.org/' + API_VERSION;
    private static final Integer HTTP_OK_CODE = 200;
    private static final String LANGUAGE = 'en-US';
    private static final Map<ResourceType, String> RESOURCE_URL_MAP = new Map<ResourceType, String> {
        ResourceType.TOP_RATED_MOVIES => '/movie/top_rated',
        ResourceType.MOVIE_DETAILS => '/movie/{0}',
        ResourceType.MOVIE_CREDITS => '/movie/{0}/credits',
        ResourceType.MOVIE_IMAGES => '/movie/{0}/images',
        ResourceType.MOVIE_VIDEOS => '/movie/{0}/videos',
        ResourceType.PERSON_DETAILS => '/person/{0}',
        ResourceType.PERSON_MOVIE_CREDITS => '/person/{0}/movie_credits',
        ResourceType.PERSON_IMAGES => '/person/{0}/images',
        ResourceType.MOVIE_ADD_RATING => '/movie/{0}/rating'
    };
    private static final Integer MAX_REQUEST_TIMEOUT = 120000;
    public enum ResourceType {
        TOP_RATED_MOVIES,
        MOVIE_DETAILS,
        MOVIE_CREDITS,
        MOVIE_IMAGES,
        MOVIE_VIDEOS,
        PERSON_DETAILS,
        PERSON_MOVIE_CREDITS,
        PERSON_IMAGES,
        MOVIE_ADD_RATING
    }

    public static ListMovieResponse getTopRatedMovies(Integer page, String region) {
        HttpRequest request = createRequest(ResourceType.TOP_RATED_MOVIES, new Map<String, Object> {
            'region' => region,
            'page' => page,
            'language' => LANGUAGE
        });
        String responseJSON = sendRequest(request);
        ListMovieResponse response = (ListMovieResponse)System.JSON.deserialize(responseJSON, ListMovieResponse.class);
        return response;
    }

    public static Movie getMovie(Integer id) {
        //TODO: Harisha to Implement this method
        return null;
    }

    private static HttpRequest createRequest(ResourceType resource, Map<String, Object> parameters) {
        return createRequest(resource, null, parameters);
    }

    private static HttpRequest createRequest(ResourceType resource, String resourceId, Map<String, Object> parameters) {
        HttpRequest request = new HttpRequest();
        if (resource == ResourceType.MOVIE_ADD_RATING) {
            request.setMethod('POST');
        } else {
            request.setMethod('GET');
        }
        String url = buildUrl(resource, resourceId, parameters);
        request.setEndpoint(url);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setTimeout(MAX_REQUEST_TIMEOUT);
        return request;
    }

    private static String sendRequest(HttpRequest request) {
        String responseString = '';
        HttpResponse response = new Http().send(request);
        if (response.getStatusCode() == HTTP_OK_CODE) {
            responseString = response.getBody();
        } else {
            responseString = 'Error: ' + response.getStatusCode() + ' - ' + response.getStatus();
        }
        return responseString;
    }

    private static String buildUrl(ResourceType resource, String resourceId, Map<String, Object> parameters) {
        String url = API_URL + RESOURCE_URL_MAP.get(resource);
        if (resourceId != null) {
            url = String.format(url, new List<String> {
                resourceId
            });
        }

        parameters = parameters == null ? new Map<String, String>() : parameters;
        parameters.put('api_key', API_KEY);
        if (parameters != null) {
            url += '?';
            String value = '';
            for (String key : parameters.keySet()) {
                value = String.valueOf(parameters.get(key));
                url += EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(value, 'UTF-8') + '&';
            }
            url = url.removeEnd('&');
        }
        return url;
    }

}