<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
%{--<div class="nav" role="navigation">--}%
%{--    <ul>--}%
%{--        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
%{--    </ul>--}%
%{--</div>--}%
<div id="list-user" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
%{--            <f:table collection="${userList}" />--}%

    <table>
        <thead>
        <tr>

            %{--                    <th class="sortable"><a href="/user/index?sort=password&amp;max=10&amp;order=asc">Password</a></th>--}%

            <th class="sortable"><a href="/user/index?sort=username&amp;max=10&amp;order=asc">Username</a></th>

            %{--                    <th class="sortable"><a href="/user/index?sort=passwordExpired&amp;max=10&amp;order=asc">Password Expired</a></th>--}%

            %{--                    <th class="sortable"><a href="/user/index?sort=accountLocked&amp;max=10&amp;order=asc">Account Locked</a></th>--}%

            <th class="sortable"><a href="/user/index?sort=announce&amp;max=10&amp;order=asc">Announce</a></th>

            %{--                    <th class="sortable"><a href="/user/index?sort=accountExpired&amp;max=10&amp;order=asc">Account Expired</a></th>--}%

            %{--                    <th class="sortable"><a href="/user/index?sort=enabled&amp;max=10&amp;order=asc">Enabled</a></th>--}%

        </tr>
        </thead>
        <tbody>

        <g:each in="${userList}" var="users">
            <tr class="even">
                <td>
                    <g:link controller="user" action="show" id="${users.id}">
                        ${users.username}
                    </g:link>
                </td>

                <td>
                    <g:each in="${users.announce}" var="announces">
                        <g:link controller="announce" action="show" id="${announces.id}">
                            <li style="display: block">
                                ${announces.title}
                            </li>
                        </g:link>
                    </g:each>
                </td>

            </tr>
        </g:each>

        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${userCount ?: 0}" />
    </div>
</div>
</body>
</html>