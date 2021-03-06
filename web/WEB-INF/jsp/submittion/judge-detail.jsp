<%--
  Created by IntelliJ IDEA.
  User: xanarry
  Date: 18-1-7
  Time: 下午1:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fnt" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>提交记录</title>
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/oj.css">

    <script src="/js/jquery-3.2.1.min.js"></script>
    <script src="/js/bootstrap/popper.min.js"></script>
    <script src="/js/bootstrap/bootstrap.min.js"></script>

    <link rel="stylesheet" href="/plugin/highlight/css/default.css">
    <script src="/plugin/highlight/js/highlight.pack.js"></script>

    <script>
        $(document).ready(function () {
            hljs.initHighlighting();
        });
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp"/>
<div class="container custom-container">
    <div class="card">
        <h5 class="card-header">详细评测结果</h5>
        <table class="table table-sm table-striped" style="margin-bottom: 0rem;">
            <thead>
            <tr>
                <th class="text-center">测试点</th>
                <th class="text-center">耗时(ms)</th>
                <th class="text-center">内存(KB)</th>
                <th class="text-center">结果</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${detailList}" var="detail">
                <tr>
                    <td class="text-center">#${detail.testPointID}</td>
                    <td class="text-center">${detail.timeConsume}</td>
                    <td class="text-center">${detail.memConsume}</td>
                    <td class="text-center">
                        <c:choose>
                            <c:when test="${detail.result == 'Queuing'}"><span
                                    class="badge badge-secondary">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Compiling'}"><span
                                    class="badge badge-secondary">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Running'}"><span
                                    class="badge badge-primary">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Accepted'}"><span
                                    class="badge badge-success">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Presentation Error'}"><span
                                    class="badge badge-warning">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Wrong Answer'}"><span
                                    class="badge badge-danger">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Time Limit Exceeded'}"><span
                                    class="badge badge-warning">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Memory Limit Exceeded'}"><span
                                    class="badge badge-warning">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Output Limit Exceeded'}"><span
                                    class="badge badge-warning">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Runtime Error'}"><span
                                    class="badge badge-danger">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'System Error'}"><span
                                    class="badge badge-dark">${detail.result}</span></c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${detail.result == 'Compilation Error'}"><span
                                    class="badge badge-warning">${detail.result}</span></c:when>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <br>

    <c:if test="${(not empty cookie.get('userID') and cookie.get('userID').value == record.userID) or cookie.get('userType').value > 0}">
        <h4>源代码&nbsp;<small class="text-muted">${record.language}</small></h4>
        <pre><code class="form-control"><c:out value="${record.sourceCode}" escapeXml="true"></c:out> </code></pre>

        <c:if test="${fnt:length(compileInfo.compileResult) > 0}">
            <h4>编译信息</h4>
            <pre><code class="form-control"><c:out value="${compileInfo.compileResult}" escapeXml="true"></c:out></code></pre>
        </c:if>

        <%--如果错误信息不为空, 并且登录用户不是普通用户, 显示错误信息--%>
        <c:if test="${fnt:length(systemError.errorMessage) > 0 && not empty cookie.get('userType') && cookie.get('userType').value > 0}">
            <h4>错误信息</h4>
            <pre><code class="form-control"><c:out value="${systemError.errorMessage}" escapeXml="true"></c:out></code></pre>
        </c:if>
    </c:if>

    <div class="text-center">
        <c:choose>
            <c:when test="${record.contestID != 0}">
                <a class="btn btn-primary" href="/contest-record-list?contestID=${record.contestID}">返回列表</a>
            </c:when>
            <c:otherwise><a class="btn btn-primary" href="/record-list">返回列表</a></c:otherwise>
        </c:choose>

        <c:if test="${not empty cookie.get('userType') and cookie.get('userType').value > 0}">
            <a class="btn btn-warning" href="/rejudge?submitID=${record.submitID}">重新评测</a>
        </c:if>
    </div>


    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>

