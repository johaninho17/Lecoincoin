<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
    <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>

    <style type="text/css" media="screen">

    .container .Grid_Nav{ grid-area : gridnav;}
    .container .log {grid-area : log;}
    .container .navbar-brand { grid-area : barnav;}

    .container {
        height: auto;
        width: auto;
        display: grid;
        grid-template-columns: auto 80% auto;
        grid-template-areas:
    "barnav gridnav log"
    }

    .Grid_Nav .UserTotal {
        display: block;
        font-size: 20px;
        font-family: 'Courier New', Courier, monospace;
        color: white;
        text-align: center;
        margin: auto;
    }
    .Grid_Nav  .AnnounceTotal{
        display: block;
        font-size: 20px;
        font-family: 'Courier New', Courier, monospace;
        color: white;
        text-align: center;
        margin: auto;
    }

    .Grid_Nav  .TitreCoincoin{
        font-size: 40px;
        margin: auto;
        font-family: 'Courier New', Courier, monospace;
        color: black;
        text-align: center;
    }

    .Grid_Nav .UserTotal { grid-area : showUser;}
    .Grid_Nav .AnnounceTotal {grid-area : showAnnounce;}
    .Grid_Nav .TitreCoincoin { grid-area : Coin;}

    .Grid_Nav {
        height: 100%;
        width: 100%;
        display: grid;
        grid-template-rows: auto;
        grid-template-columns: auto 25% auto;
        grid-template-areas:
    "showUser Coin showAnnounce"
    }

    a {
        text-decoration: none;
    }

    /* Page structure */

    .intro-and-nav {
        font-size: 0.8rem;
        width: 15rem;
        height : 50rem
    }

    .patterns {
        flex: 1 1 auto;
    }
    /* Patterns navigation */
    .patterns {
        margin-top: 1.5rem;
    }
    .patterns * {
        margin-top: 0;
    }
    .patterns h3 {
        font-size: 1rem;
    }
    .patterns h3 + ul {
        margin-top: 0.75rem;
    }
    .patterns li {
        line-height: 1.125;
        list-style: none;
    }
    .patterns li + li {
        margin-top: 0.75rem;
    }
    .patterns ul ul {
        margin-left: 0.75rem;
    }
    .pattern a {
        border: 0;
        display: flex;
        flex-wrap: nowrap;
        align-items: baseline;
        font-weight: bold;
        padding: 0 1rem;
    }


    /* SVG icons */
    a svg, .vh {
        clip: rect(1px, 1px, 1px, 1px);
        height: 1px;
        overflow: hidden;
        position: absolute;
        white-space: nowrap;
        width: 1px;
    }

    .bodyotherbis{
        margin: 0 auto;
        width: 80%;
    }

    </style>
</head>
<body>

<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <a class="navbar-brand" href="/#">
            <img src="${grailsApplication.config.assets.url}coung.png" alt="Grails Logo"/>
        </a>
        <div class ="Grid_Nav">
            <div class = "UserTotal">
                <p> TOTAL USER : </p>
                ${josproject.User.count}
            </div>
            <div class = "AnnounceTotal">
                <p> TOTAL ANNONCE : </p>
                ${josproject.Announce.count}
            </div>
            <div class = "TitreCoincoin">
                <p>KOINKOIN</p>
            </div>
        </div>
        <div class ="log">
            <ul class="nav navbar-nav navbar-right">
                <g:pageProperty name="page.nav" />
                <sec:ifLoggedIn>
                    <p style="color: white">Welcome <sec:loggedInUserInfo field='username'/></p>
                    <g:link controller="logout" action="index">
                        Logout !
                    </g:link>
                </sec:ifLoggedIn>
            </ul>
        </div>
    </div>
</div>

<sec:ifLoggedIn>
    <div class="wrapper" style="display: flex">

        <header class="intro-and-nav" role="banner">
            <div>
                <nav id="patterns-nav" class="patterns" role="navigation">
                    <ul id="patterns-list">

                        <li class="pattern">

                            <a href="/">
                                <svg class="bookmark-icon" aria-hidden="true" focusable="false" viewBox="0 0 40 50">
                                    <use xlink:href="#bookmark"></use>
                                </svg>
                                <span class="text">Home</span>
                            </a>
                        </li>

                        <li class="pattern">

                            <a href="/announce/index" aria-current="page">
                                <svg class="bookmark-icon" aria-hidden="true" focusable="false" viewBox="0 0 40 50">
                                    <use xlink:href="#bookmark"></use>
                                </svg>
                                <span class="text">Liste des annonces</span>
                            </a>
                        </li>

                        <li class="pattern">
                            <a href="/announce/indexuser">
                                <svg class="bookmark-icon" aria-hidden="true" focusable="false" viewBox="0 0 40 50">
                                    <use xlink:href="#bookmark"></use>
                                </svg>
                                <span class="text">Tes Announces</span>
                            </a>
                        </li>

                        <li class="pattern">
                            <a href="/announce/create">
                                <svg class="bookmark-icon" aria-hidden="true" focusable="false" viewBox="0 0 40 50">
                                    <use xlink:href="#bookmark"></use>
                                </svg>
                                <span class="text">Create Announce</span>
                            </a>
                        </li>

                        <li class="pattern">
                            <a href="/user/show/${sec.loggedInUserInfo(field: "id")}">
                                <svg class="bookmark-icon" aria-hidden="true" focusable="false" viewBox="0 0 40 50">
                                    <use xlink:href="#bookmark"></use>
                                </svg>
                                <span class="text">Profile</span>
                            </a>
                        </li>
                        <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_MOD">
                            <li class="pattern">
                                <a href="/user/index">
                                    <svg class="bookmark-icon" aria-hidden="true" focusable="false" viewBox="0 0 40 50">
                                        <use xlink:href="#bookmark"></use>
                                    </svg>
                                    <span class="text">Liste des utilisateurs</span>
                                </a>
                            </li>

                            <li class="pattern">
                                <a href="/user/create">
                                    <svg class="bookmark-icon" aria-hidden="true" focusable="false" viewBox="0 0 40 50">
                                        <use xlink:href="#bookmark"></use>
                                    </svg>
                                    <span class="text">Create User</span>
                                </a>
                            </li>

                            <li class="pattern">
                                <a href="/dbconsole">
                                    <svg class="bookmark-icon" aria-hidden="true" focusable="false" viewBox="0 0 40 50">
                                        <use xlink:href="#bookmark"></use>
                                    </svg>
                                    <span class="text">Base de données Console</span>
                                </a>
                            </li>
                        </sec:ifAnyGranted>

                    </ul>
                </nav>
            </div>
        </header>

        <div class ="bodyotherbis">
            <g:layoutBody/>

            <div class="footer" role="contentinfo"></div>

            <div id="spinner" class="spinner" style="display:none;">
                <g:message code="spinner.alt" default="Loading&hellip;"/>
            </div>

            <asset:javascript src="application.js"/>
        </div>
    </div>

</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
    <div class ="bodyother">
        <g:layoutBody/>

        <div class="footer" role="contentinfo"></div>

        <div id="spinner" class="spinner" style="display:none;">
            <g:message code="spinner.alt" default="Loading&hellip;"/>
        </div>

        <asset:javascript src="application.js"/>
    </div>
</sec:ifNotLoggedIn>

</body>
</html>
