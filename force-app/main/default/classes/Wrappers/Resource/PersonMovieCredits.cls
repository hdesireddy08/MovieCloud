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
public inherited sharing class PersonMovieCredits {
    @AuraEnabled
    public List<PersonMovieRole> cast_members { get; set; }
    @AuraEnabled
    public List<PersonMovieRole> crew_members { get; set; }

    public static PersonMovieCredits parse(String json) {
        return (PersonMovieCredits) System.JSON.deserialize(
            json.replace('"cast"', '"cast_members"').replace('"crew"', '"crew_members"'),
            PersonMovieCredits.class
        );
    }
}