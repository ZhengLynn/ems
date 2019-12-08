<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>regist</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
        $(function () {
            //错误提示
            var message = $('#message').val();
            if (message != null && message != '' && message != '用户名已存在') {
                window.alert(message);
            }
        });

        //刷新验证码
        function flushCode() {
            var num = document.getElementById('num');
            num.src = '${pageContext.request.contextPath}/manager/securityCode?' + Math.random();
        }

        //验证username是否为空
        function checkUsername(ipt) {
            var val = ipt.value;
            if (val == "" || val == null || (val.length > 0 && val.trim().length == 0)) {
                $('#msg').css('color', 'red');
                $('#msg').text('  此项不能为空');
                return;
            }
            //定义xhr
            var xhr;
            if (window.ActiveXObject) {
                xhr = new ActiveXObject('Microsoft.xmlhttp');
            } else {
                xhr = new XMLHttpRequest();
            }
            xhr.open('GET', '${pageContext.request.contextPath}/manager/checkUsername?username=' + val);
            xhr.send();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var txt = xhr.responseText;
                    if (txt == '  用户名已存在') {
                        $('#msg').css('color', 'red');
                        $('#jud').val('false');
                    } else {
                        $('#msg').css('color', 'green');
                        $('#jud').val('true');
                    }
                    $('#msg').html(txt);
                }
            }
        }

        //判断各个输入框是否为空
        function judgeInput(ipt) {
            var value = ipt.value;
            if (value == "" || value == null || (value.length > 0 && value.trim().length == 0)) {
                $(ipt).next().css('color', 'red');
                ipt.nextSibling.innerText = '  此项不能为空';
                return false;
            } else {
                $(ipt).next().css('color', 'green');
                ipt.nextSibling.innerText = '  格式正确';
                return true;
            }
        }

        //表单提交验证
        function check() {
            var username = document.getElementById('username');
            var name = document.getElementById('name');
            var password = document.getElementById('password');
            var code = document.getElementById('code');
            checkUsername(username);
            var b = true;
            if (!judgeInput(name)) b = false;
            if (!judgeInput(password)) b = false;
            if (!judgeInput(code)) b = false;
            if (!judgeInput(username)) {
                if ($('#jud').val() == 'false') {
                    $('#msg').css('color', 'red');
                    $('#msg').html('  用户名已存在');
                    b = false;
                }
                b = false;
            }
            if (b && $('#jud').val() == 'true') {
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
                注册
            </h1>
            <form action="${pageContext.request.contextPath}/manager/register" method="post" onsubmit="return check()">
                <table cellpadding="0" cellspacing="0" border="0"
                       class="form_table">
                    <tr>
                        <td valign="middle" align="right">
                            用户名:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" id="username" name="username"
                                   onblur="checkUsername(this)"/><span id="msg"
                                                                       style="font-family:'幼圆';color:red;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            真实姓名:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" id="name" name="name" onblur="judgeInput(this)"/><span
                                style="font-family:'幼圆';color:red;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            密码:
                        </td>
                        <td valign="middle" align="left">
                            <input type="password" class="inputgri" id="password" name="password"
                                   onblur="judgeInput(this)"/><span style="font-family:'幼圆';color:red;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            性别:
                        </td>
                        <td valign="middle" align="left">
                            男
                            <input type="radio" class="inputgri" name="sex" value="男" checked="checked"/>
                            女
                            <input type="radio" class="inputgri" name="sex" value="女"/>
                        </td>
                    </tr>

                    <tr>
                        <td valign="middle" align="right">
                            验证码:
                            <img id="num" src="${pageContext.request.contextPath}/manager/securityCode"/>
                            <a href="javascript:void(0);" onclick="flushCode()">换一张</a>
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" name="code" id="code" onblur="judgeInput(this)"/><span
                                style="font-family:'幼圆';color:red;"></span>
                        </td>
                    </tr>
                </table>
                <p>
                    <input type="button" class="button" value="&laquo; Go Back" onclick="history.go(-1);"/>
                    &nbsp;&nbsp;
                    <input type="submit" class="button" value="Submit &raquo;"/>
                    <input type="hidden" id="message" name="message" value="${requestScope.message}">
                    <input type="hidden" id="jud" value="">
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
