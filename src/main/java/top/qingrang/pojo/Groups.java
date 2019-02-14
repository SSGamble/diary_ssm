package top.qingrang.pojo;

public class Groups {
    private Integer id;

    private Integer parent_id;

    private String groups;

    private Integer g_count;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getParent_id() {
        return parent_id;
    }

    public void setParent_id(Integer parent_id) {
        this.parent_id = parent_id;
    }

    public String getGroups() {
        return groups;
    }

    public void setGroups(String groups) {
        this.groups = groups == null ? null : groups.trim();
    }

    public Integer getG_count() {
        return g_count;
    }

    public void setG_count(Integer g_count) {
        this.g_count = g_count;
    }
}