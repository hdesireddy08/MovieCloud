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
public inherited sharing class PersonMovieRole extends MovieRole {
    @AuraEnabled
    public String backdrop_path;
    @AuraEnabled
    public List<Integer> genre_ids;
    @AuraEnabled
    public String original_language;
    @AuraEnabled
    public String original_title;
    @AuraEnabled
    public String overview;
    @AuraEnabled
    public String poster_path;
    @AuraEnabled
    public String release_date;
    @AuraEnabled
    public String title;
    @AuraEnabled
    public Boolean video;
    @AuraEnabled
    public Double vote_average;
    @AuraEnabled
    public Integer vote_count;

    public static PersonMovieRole parse(String json) {
        return (PersonMovieRole) System.JSON.deserialize(json, PersonMovieRole.class);
    }

}