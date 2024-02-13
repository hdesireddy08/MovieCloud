/*
 * -----------------------------------------------------------------------------
 * COPYRIGHT (C) 2024, FONTEVA, INC.
 * ALL RIGHTS RESERVED.
 *
 * ALL INFORMATION CONTAINED HEREIN IS, AND REMAINS THE PROPERTY OF FONTEVA
 * INCORPORATED AND ITS SUPPLIERS, IF ANY. THE INTELLECTUAL AND TECHNICAL
 * CONCEPTS CONTAINED HEREIN ARE PROPRIETARY TO FONTEVA INCORPORATED AND
 * ITS SUPPLIERS AND MAY BE COVERED BY U.S. AND FOREIGN PATENTS, PATENTS IN
 * PROCESS, AND ARE PROTECTED BY TRADE SECRET OR COPYRIGHT LAW. DISSEMINATION
 * OF THIS INFORMATION OR REPRODUCTION OF THIS MATERIAL IS STRICTLY FORBIDDEN
 * UNLESS PRIOR WRITTEN PERMISSION IS OBTAINED FROM FONTEVA, INC.
 * -----------------------------------------------------------------------------
 */
public inherited sharing class MovieApi {
    private static final String API_KEY = 'ebefb9c9b7bfbb144a0e42b22b148b8c';
    private static final String API_VERSION = '3';
    private static final String API_URL = 'https://api.themoviedb.org/' + API_VERSION;
    private static final Integer HTTP_OK_CODE = 200;
    private static final Map<ResourceType, String> RESOURCE_URL_MAP = new Map<ResourceType, String> {
        ResourceType.TOP_RATED_MOVIES => '/movie/top_rated',
        ResourceType.DISCOVER_MOVIES => '/discover/movie',
        ResourceType.GENRE_MOVIES => '/genre/movie/list',
        ResourceType.COUNTRIES => '/configuration/countries',
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
        DISCOVER_MOVIES,
        GENRE_MOVIES,
        MOVIE_DETAILS,
        MOVIE_CREDITS,
        MOVIE_IMAGES,
        MOVIE_VIDEOS,
        PERSON_DETAILS,
        PERSON_MOVIE_CREDITS,
        PERSON_IMAGES,
        MOVIE_ADD_RATING,
        COUNTRIES
    }

    public static ListMovie getMovies(Map<String, Object> parameters) {
        String jsonResponse = processRequest(ResourceType.DISCOVER_MOVIES, parameters);
        return ListMovie.parse(jsonResponse);
    }

    private static String processRequest(ResourceType resource, Map<String, Object> parameters) {
        HttpRequest request = createRequest(resource, null, parameters);
        return sendRequest(request);
    }

    private static String processRequest(ResourceType resource, Object resourceId, Map<String, Object> parameters) {
        HttpRequest request = createRequest(resource, resourceId, parameters);
        return sendRequest(request);
    }

    private static String sendRequest(HttpRequest request) {
        HttpResponse response = new Http().send(request);
        if (response.getStatusCode() != HTTP_OK_CODE) {
            throw new MovieApiException('Error: ' + response.getBody());
        }
        return response.getBody();
    }

    private static HttpRequest createRequest(ResourceType resource, Object resourceId, Map<String, Object> parameters) {
        HttpRequest request = new HttpRequest();
        request.setMethod(resource == ResourceType.MOVIE_ADD_RATING ? 'POST' : 'GET');
        request.setEndpoint(buildUrl(resource, resourceId, parameters));
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setTimeout(MAX_REQUEST_TIMEOUT);
        return request;
    }

    private static String buildUrl(ResourceType resource, Object resourceId, Map<String, Object> parameters) {
        String url = API_URL + RESOURCE_URL_MAP.get(resource);
        if (resourceId != null) {
            url = String.format(url, new List<Object> {
                resourceId
            });
        }

        url += '?api_key=' + EncodingUtil.urlEncode(API_KEY, 'UTF-8');
        url += buildUrlParams(parameters);
        return url;
    }

    private static String buildUrlParams(Map<String, Object> parameters) {
        String url = '';
        if (parameters != null) {
            for (String key : parameters.keySet()) {
                String value = String.valueOf(parameters.get(key));
                url += '&' + EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(value, 'UTF-8');
            }
        }
        return url;
    }

    public class MovieApiException extends Exception {
    }
}