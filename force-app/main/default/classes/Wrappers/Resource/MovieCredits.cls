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
public inherited sharing class MovieCredits {
    public List<MovieRole> cast_members { get; set; }
    public List<MovieRole> crew_members { get; set; }

    public static MovieCredits parse(String json) {
        return (MovieCredits) System.JSON.deserialize(
            json.replace('"cast"', '"cast_members"').replace('"crew"', '"crew_members"'),
            MovieCredits.class
        );
    }
}