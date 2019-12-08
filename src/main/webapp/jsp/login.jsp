<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>login</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/src/main/webapp/static/css/style.css"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/src/main/webapp/static/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
        //错误提示
        $(function () {
            var message = $('#message').val();
            console.log(message);
            if (message != null && message != '') {
                window.alert(message);
            }
        });

        //验证用户名是否为空
        function checkUsername(ipt) {
            var username = ipt.value;
            if (username == null || username == '' || username.trim().length == 0) {
                ipt.nextSibling.innerText = '  用户名不能为空';
                return false;
            } else {
                ipt.nextSibling.innerText = '';
                return true;
            }
        }

        //验证密码是否为空
        function checkPassword(ipt) {
            var password = ipt.value;
            if (password == null || password == '' || password.trim().length == 0) {
                ipt.nextSibling.innerText = '  密码不能为空';
                return false;
            } else {
                ipt.nextSibling.innerText = '';
                return true;
            }
        }

        //表单提交验证
        function check() {
            var username = document.getElementById('username');
            var password = document.getElementById('password');
            if (checkUsername(username) && checkPassword(password)) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</head>

<body>
<div id="wrap">
    <div id="top_content">
        <div id="header">
            <div id="rightheader">
                <p>
                    <jsp:useBean id="now" class="java.util.Date" scope="page"/>
                    <fmt:formatDate value="${now}" pattern="yyyy年MM月dd日"/>
                    <br/>
                </p>
            </div>
            <div id="topheader">
                <h1 id="title">
                    <a href="#">main</a>
                </h1>
            </div>
            <div id="navigation">
            </div>
        </div>
        <div id="content">
            <p id="whereami">
            </p>
            <h1>
                login
            </h1>
            <form action="${pageContext.request.contextPath}/manager/login" method="post">
                <table cellpadding="0" cellspacing="0" border="0"
                       class="form_table">
                    <tr>
                        <td valign="middle" align="right">
                            username:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" id="username" name="username"
                                   onblur="checkUsername(this)"/><span style="font-family:'幼圆';color:red;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            password:
                        </td>
                        <td valign="middle" align="left">
                            <input type="password" class="inputgri" id="password" name="password"
                                   onblur="checkPassword(this)"/><span style="font-family:'幼圆';color:red;"></span>
                        </td>
                    </tr>
                </table>
                <p>
                    <input type="submit" class="button" value="Submit &raquo;"/>
                    &nbsp;&nbsp;
                    <input type="button" class="button"
                           onclick="location.href='${pageContext.request.contextPath}/register.jsp'"
                           value="Regist &raquo;"/>
                    <input type="hidden" id="message" name="message" value="${requestScope.message}">
                </p>
            </form>
        </div>
    </div>
    <div id="footer">
        <div id="footer_bg">
            ABC@126.com
        </div>
    </div>
</div>
</body>
</html>
