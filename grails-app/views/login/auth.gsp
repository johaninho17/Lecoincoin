<html>
<head>
    <meta name="layout" content="${gspLayout ?: 'main'}"/>
    <title><g:message code='springSecurity.login.title'/></title>
    <style type="text/css" media="screen">


    #login .inner {
        width: 340px;
        padding-bottom: 6px;
        margin: 60px auto;
        text-align: left;
        border: 1px solid #aab;
        background-color: #f0f0fa;
        -moz-box-shadow: 2px 2px 2px #eee;
        -webkit-box-shadow: 2px 2px 2px #eee;
        -khtml-box-shadow: 2px 2px 2px #eee;
        box-shadow: 2px 2px 2px #eee;
    }

    #login .inner .fheader {
        padding: 18px 26px 14px 26px;
        background-color: #f7f7ff;
        color: #2e3741;
        font-size: 18px;
        font-weight: bold;
    }

    #login .inner .cssform p {
        clear: left;
        margin: 0;
        padding: 4px 0 3px 0;
        padding-left: 105px;
        margin-bottom: 20px;
        height: 1%;
    }

    #login .inner .cssform input[type="text"] {
        width: 120px;
    }

    #login .inner .cssform label {
        font-weight: bold;
        float: left;
        text-align: right;
        margin-left: -105px;
        width: 110px;
        padding-top: 3px;
        padding-right: 10px;
    }

    #login #remember_me_holder {
        padding-left: 120px;
    }

    #login #submit {
        margin-left: 15px;
    }

    #login #remember_me_holder label {
        float: none;
        margin-left: 0;
        text-align: left;
        width: 200px
    }

    #login .inner .login_message {
        padding: 6px 25px 20px 25px;
        color: #c33;
    }

    #login .inner .text_ {
        width: 120px;
    }

    #login .inner .chk {
        height: 12px;
    }

    .containerList{
        height : 80%;
        background-image: url("${grailsApplication.config.assets.url}jobdeal.png");
        background-repeat: no-repeat;
        background-position: center;
        background-size:100% 100%;
    }
    .containerList .List{
        display: flex;
        flex-direction: flex;
    }

    .containerList .List .avatar {
        max-width: 50%;
        height: auto;
        display: block;
        margin-left: auto;
        margin-right: auto;
        opacity: 0.9;
    }
    .containerList .List .paragraph{
        font-size: 40px;
        margin: auto;
        font-family: 'Courier New', Courier, monospace;
        color: black;
        text-align: center;
    }

    .containerList .List .login{
        margin-top: -20px;
        opacity: 0.9;
    }

    .GridList .avatar { grid-area : avatar;}
    .GridList .paragraph {grid-area : para1;}
    .GridList .login { grid-area : log;}

    .containerList .List .GridList{
        height : 100%;
        width: 100%;
        display: grid;
        grid-template-columns: 50% 50%;
        grid-template-rows: 25% 75%;
        grid-template-areas:
    "para1 para1"
    "avatar log"
    }

    .buttonNewAccount{
        margin-left: auto;
        margin-right: auto;
        -webkit-appearance: button;
        cursor: pointer;
        background-color: #fcfcfc;

    }
    </style>
</head>

<body>
<div class ="containerList">
    <section class ="List">
        <div class ="GridList">
            <img src="${grailsApplication.config.assets.url}Leooin.png" class="avatar">
            <p class="paragraph"> Avec <strong>JOSHARE</strong> <br/> J'enchère </p>
            <div id="login" class="login">
                <div class="inner">
                    <div class="fheader"><g:message code='springSecurity.login.header'/></div>
                    <g:if test='${flash.message}'>
                        <div class="login_message">${flash.message}</div>
                    </g:if>
                    <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="cssform" autocomplete="off">
                        <p>
                            <label for="username"><g:message code='springSecurity.login.username.label'/>:</label>
                            <input type="text" class="text_" name="${usernameParameter ?: 'username'}" id="username"/>
                        </p>

                        <p>
                            <label for="password"><g:message code='springSecurity.login.password.label'/>:</label>
                            <input type="password" class="text_" name="${passwordParameter ?: 'password'}" id="password"/>
                        </p>

                        <p id="remember_me_holder">
                            <input type="checkbox" class="chk" name="${rememberMeParameter ?: 'remember-me'}" id="remember_me"
                                   <g:if test='${hasCookie}'>checked="checked"</g:if>/>
                            <label for="remember_me"><g:message code='springSecurity.login.remember.me.label'/></label>
                        </p>

                        <p>
                            <input type="submit" id="submit" value="${message(code: 'springSecurity.login.button')}"/>
                        </p>
                        <div class="buttonNewAccount">
                            <p><g:link controller="user" class="create" action="create"> Create new account </g:link></p>
                        </div>


                    </form>
                </div>
            </div>
        </div>
    </section>
</div>
<script>
    (function () {
        document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
    })();
</script>
</body>
</html>
