<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
%{--<div class="nav" role="navigation">--}%
%{--    <ul>--}%
%{--        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
%{--        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>--}%
%{--        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
%{--    </ul>--}%
%{--</div>--}%
<div id="show-user" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <ol class="property-list user">

        <li class="fieldcontain">
            <span id="username-label" class="property-label">Username</span>
            <div name="name" id="name" class="property-value" aria-labelledby="username-label">${user.username}</div>
        </li>

        <g:each in="${user.announce}" var="announce">
            <ul class="fieldcontain">
                <g:link controller="announce" action="show" id="${announce.id}">
                    ${announce.title}
                </g:link>
            </ul>
        </g:each>

    %{--                <sec:ifAnyGranted roles="ROLE_ADMIN">--}%
    %{--                    <li class="fieldcontain">--}%
    %{--                        <span id="password-label" class="property-label">Password</span>--}%
    %{--                        <div class="property-value" aria-labelledby="password-label">$2a$10$Rfo3CRHriBsudeHGvqI7B.3gw52gcncdMQYjhK1lgsgWPPLqcnW4m</div>--}%
    %{--                    </li>--}%


    %{--                    <li class="fieldcontain">--}%
    %{--                        <span id="passwordExpired-label" class="property-label">Password Expired</span>--}%
    %{--                        <div class="property-value" aria-labelledby="passwordExpired-label">False</div>--}%
    %{--                    </li>--}%

    %{--                    <li class="fieldcontain">--}%
    %{--                        <span id="accountLocked-label" class="property-label">Account Locked</span>--}%
    %{--                        <div class="property-value" aria-labelledby="accountLocked-label">False</div>--}%
    %{--                    </li>--}%


    %{--                    <li class="fieldcontain">--}%
    %{--                        <span id="accountExpired-label" class="property-label">Account Expired</span>--}%
    %{--                        <div class="property-value" aria-labelledby="accountExpired-label">False</div>--}%
    %{--                    </li>--}%

    %{--                    <li class="fieldcontain">--}%
    %{--                        <span id="enabled-label" class="property-label">Enabled</span>--}%
    %{--                        <div class="property-value" aria-labelledby="enabled-label">True</div>--}%
    %{--                    </li>--}%
    %{--                </sec:ifAnyGranted>--}%
    </ol>

    <g:if test="${sec.username() == user.username} || ${SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")}">
        <g:form resource="${this.user}" method="DELETE">
            <fieldset class="buttons">
                <g:link class="edit" action="edit" resource="${this.user}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
            </fieldset>
        </g:form>
    </g:if>
</div>
</body>
</html>
