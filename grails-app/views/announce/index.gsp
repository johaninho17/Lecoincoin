<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'announce.label', default: 'Announce')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <h1 style="font-size: 25px; text-align: center ">LES ANNONCES</h1>
        <a href="#list-announce" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
%{--        <div class="nav" role="navigation">--}%
%{--            <ul>--}%
%{--                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
%{--                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
%{--                <li><g:link class="indexuser" action="indexuser">Tes annonces</g:link></li>--}%
%{--            </ul>--}%
%{--        </div>--}%
        <div id="list-announce" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
           <!-- <f:table collection="${announceList}"/> -->

            <table>
                <thead>
                <tr>

                    <th class="sortable"><a href="/announce/index?sort=title&amp;max=10&amp;order=asc">Title</a></th>

                    <th class="sortable"><a href="/announce/index?sort=description&amp;max=10&amp;order=asc">Description</a></th>

                    <th class="sortable"><a href="/announce/index?sort=price&amp;max=10&amp;order=asc">Price</a></th>

                    <th class="sortable"><a href="/announce/index?sort=illustrations&amp;max=10&amp;order=asc">Illustrations</a></th>

                    <th class="sortable"><a href="/announce/index?sort=author&amp;max=10&amp;order=asc">Author</a></th>

                </tr>
                </thead>

            <tbody>
                <g:each in="${announceList}" var="announce">
                    <g:if test="${sec.loggedInUserInfo(field: 'username') != announce.author.username}">
                        <tr class="even">
                            <td>
                                <g:link controller="announce" action="show" id="${announce.id}">
                                    ${announce.title}
                                </g:link>
                            </td>

                            <td>
                                ${announce.description}
                            </td>

                            <td>
                                ${announce.price}
                            </td>

                            <td>
                                <g:each in="${announce.illustrations}" var="illustration">
                                %{--                                <asset:image src="${illustration.filename}"/>--}%
                                    <img src="${grailsApplication.config.assets.url + illustration.filename}">
                                </g:each>
                            </td>

                            <td>
                                <g:link controller="user" action="show" id="${announce.author.id}">
                                    ${announce.author.username}
                                </g:link>
                            </td>

                        </tr>
                    </g:if>
                </g:each>


            </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${announceCount ?: 0}" />
            </div>

        </div>
    </body>
</html>