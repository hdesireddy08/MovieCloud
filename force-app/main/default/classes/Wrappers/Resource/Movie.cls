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
public inherited sharing class Movie {
    @AuraEnabled
    public Boolean adult { get; set; }
    @AuraEnabled
    public String backdrop_path { get; set; }
    @AuraEnabled
    public List<Integer> genre_ids { get; set; }
    @AuraEnabled
    public Integer id { get; set; }
    @AuraEnabled
    public String original_language { get; set; }
    @AuraEnabled
    public String original_title { get; set; }
    @AuraEnabled
    public String overview { get; set; }
    @AuraEnabled
    public Decimal popularity { get; set; }
    @AuraEnabled
    public String poster_path { get; set; }
    @AuraEnabled
    public Date release_date { get; set; }
    @AuraEnabled
    public String title { get; set; }
    @AuraEnabled
    public Boolean video { get; set; }
    @AuraEnabled
    public Decimal vote_average { get; set; }
    @AuraEnabled
    public Integer vote_count { get; set; }

    public static Movie parse(String json) {
        return (Movie) System.JSON.deserialize(json, Movie.class);
    }
}