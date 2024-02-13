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
public inherited sharing virtual class MovieRole {
    @AuraEnabled
    public Boolean adult;
    @AuraEnabled
    public Integer gender;
    @AuraEnabled
    public Integer id;
    @AuraEnabled
    public String known_for_department;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String original_name;
    @AuraEnabled
    public Double popularity;
    @AuraEnabled
    public String profile_path;
    @AuraEnabled
    public String credit_id;

    // Properties specific to cast roles
    @AuraEnabled
    public String character;
    @AuraEnabled
    public Integer cast_id;
    @AuraEnabled
    public Integer order;

    // Properties specific to crew roles
    @AuraEnabled
    public String department;
    @AuraEnabled
    public String job;

    public static MovieRole parse(String json) {
        return (MovieRole) System.JSON.deserialize(json, MovieRole.class);
    }

}