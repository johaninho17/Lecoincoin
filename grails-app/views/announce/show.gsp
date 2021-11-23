<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'announce.label', default: 'Announce')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-announce" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
%{--        <div class="nav" role="navigation">--}%
%{--            <ul>--}%
%{--                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
%{--                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>--}%
%{--                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
%{--            </ul>--}%
%{--        </div>--}%
        <div id="show-announce" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
 %{--        <f:display bean="announce" />--}%

            <ol class="property-list announce">

                <li class="fieldcontain">
                    <label for="title">TITLE
                    </label>
                    ${announce.title}
                </li>

                <li class="fieldcontain">
                    <label for="description">Description
                    </label>
                    ${announce.description}
                </li>

                <li class="fieldcontain">
                    <label for="Price">Price
                    </label>
                    ${announce.price}
                </li>

                <li class="fieldcontain">
                    <label for="illustrations">Illustrations</label>
                    <g:each in="${announce.illustrations}" var="illustration">
                        %{--<asset:image src="${illustration.filename}" />--}%
%{--
                        <img src="/Users/johaninho/grailsproj/YamssiAmetGrails/grails-app/assets/images/${illustration.filename}"
--}%
                        <img src="${grailsApplication.config.assets.url + illustration.filename}" />
                    </g:each>
                </li>

                <li class="fieldcontain">
                    <label for="author">Author
                    </label>
                    ${announce.author.username}
                </li>

            </ol>



            <g:if test="${sec.username() == announce.author} || ${SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")}">
            <g:form resource="${this.announce}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.announce}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
            </g:if>
        </div>
    </body>
</html>
