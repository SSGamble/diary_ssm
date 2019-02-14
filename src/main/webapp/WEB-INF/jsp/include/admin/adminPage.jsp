<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<script>
    $(function(){
        $("ul.pagination li.disabled a").click(function(){
            return false;
        });
    });

</script>

<div class="table_ul">
    <ul class="pagination">

        <li <c:if test="${!page.hasPreviouse}">class="disabled"</c:if>>
            <a  href="?start=0${page.param}" aria-label="Previous" >
                <span aria-hidden="true">1</span>
            </a>
        </li>

        <li <c:if test="${!page.hasPreviouse}">class="disabled"</c:if>>
            <a  href="?start=${page.start-page.count}${page.param}" aria-label="Previous" >
                <span aria-hidden="true">上一页</span>
            </a>
        </li>

        <%--<c:forEach begin="0" end="${page.totalPage-1}" varStatus="status">--%>
            <%--<c:if test="${status.index*page.count==page.start}">--%>

                <%--<li>--%>
                    <%--<a href="?start=${status.index*page.count-2*page.count}">${status.count-2}</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a href="?start=${status.index*page.count-page.count}">${status.count-1}</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a--%>
                            <%--href="?start=${status.index*page.count}${page.param}"--%>
                            <%--<c:if test="${status.index*page.count==page.start}">class="current"</c:if>--%>
                    <%-->${status.count}</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a href="?start=${status.index*page.count+page.count}">${status.count+1}</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a href="?start=${status.index*page.count+2*page.count}">${status.count+2}</a>--%>
                <%--</li>--%>
            <%--</c:if>--%>
        <%--</c:forEach>--%>

        <c:forEach begin="0" end="${page.totalPage-1}" varStatus="status">
            <c:if test="${status.index*page.count==page.start}">
                <%--<li>--%>
                    <%--<a href="?start=${status.index*page.count-2*page.count}">${status.count-2}</a>--%>
                <%--</li>--%>

                <%--<li>--%>
                    <%--<a href="?start=${status.index*page.count-1*page.count}">${status.count-1}</a>--%>
                <%--</li>--%>
                <%--<c:if test="${page.hasPreviouse}">--%>
                    <%--<li>--%>
                        <%--<a>.</a>--%>
                    <%--</li>--%>
                <%--</c:if>--%>

                <li <c:if test="${status.index*page.count==page.start}">class="disabled"</c:if>>
                    <a href="?start=${status.index*page.count}${page.param}"
                            <c:if test="${status.index*page.count==page.start}">class="current"</c:if>
                    >${status.count}</a>
                </li>

                <%--<c:if test="${page.hasNext}">--%>
                    <%--<li>--%>
                        <%--<a>.</a>--%>
                    <%--</li>--%>
                <%--</c:if>--%>
            </c:if>
        </c:forEach>

        <%--<c:forEach begin="0" end="${page.totalPage-1}" varStatus="status">--%>
            <%--<li <c:if test="${status.index*page.count==page.start}">class="disabled"</c:if>>--%>
                <%--<a href="?start=${status.index*page.count}${page.param}"--%>
                   <%--<c:if test="${status.index*page.count==page.start}">class="current"</c:if>--%>
                <%-->${status.count}</a>--%>
            <%--</li>--%>
        <%--</c:forEach>--%>

        <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
            <a href="?start=${page.start+page.count}${page.param}" aria-label="Next">
                <span aria-hidden="true">下一页</span>
            </a>
        </li>

        <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
            <a href="?start=${page.last}${page.param}" aria-label="Next">
                <span aria-hidden="true">${page.last}</span>
            </a>
        </li>
    </ul>
</div>