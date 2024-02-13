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
    public Boolean adult;
    public Integer gender;
    public Integer id;
    public String known_for_department;
    public String name;
    public String original_name;
    public Double popularity;
    public String profile_path;
    public String credit_id;

    // Properties specific to cast roles
    public String character;
    public Integer cast_id;
    public Integer order;

    // Properties specific to crew roles
    public String department;
    public String job;

    public static MovieRole parse(String json) {
        return (MovieRole) System.JSON.deserialize(json, MovieRole.class);
    }

}