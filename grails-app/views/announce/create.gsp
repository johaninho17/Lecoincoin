<%@ page import="josproject.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'announce.label', default: 'Announce')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
<a href="#create-announce" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
%{--<div class="nav" role="navigation">--}%
%{--    <ul>--}%
%{--        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
%{--        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>--}%
%{--    </ul>--}%
%{--</div>--}%
<div id="create-announce" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.announce}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.announce}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form controller="announce" action="save" method="POST" enctype="multipart/form-data">
        <fieldset class="form">
            %{--                    <f:all bean="announce"/>--}%
            <fieldset class="form">
                <div class="fieldcontain required">
                    <label for="title">Title
                        <span class="required-indicator">*</span>
                    </label><input type="text" name="title" value="" required="" id="title">
                </div><div class="fieldcontain required">
                <label for="description">Description
                    <span class="required-indicator">*</span>
                </label><input type="text" name="description" value="" required="" id="description">
            </div><div class="fieldcontain required">
                <label for="price">Price
                    <span class="required-indicator">*</span>
                </label><input type="number decimal" name="price" value="" required="" step="0.01" min="0.0" id="price">
            </div><div class="fieldcontain">
                <label for="illustrations">Illustrations : Select the Source File</label>
                <td>
                    <input size="100" type="file" id="payload" name="payload"/>
                    <span id="error"></span>

                </td>
            </div>
            <div class="fieldcontain required">
                <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_MOD">    <div class="fieldcontain required">
                    <label for="author">Author
                        <span class="required-indicator">*</span>
                    </label>
                    <g:select name="author.id" from="${josproject.User.list()}" optionKey="id" optionValue="username"></g:select>
                %{--<g:select name="author.id" from="${userList}" optionKey="id" optionValue="username"></g:select>    </div>--}%
                </sec:ifAnyGranted>
            </div>
            </fieldset>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
        </fieldset>
    </g:form>
</div>
<asset:javascript src="application.js"/>
<script type="text/javascript">
    $(function(){
        $(":file").change(function() {
            var error = document.getElementById("error")
            const file = this.files[0];
            const  fileType = file['type'];
            const validImageTypes = ['image/jpeg', 'image/png'];
            if (!validImageTypes.includes(fileType)) {
                console.log("Image non valide")
                error.textContent = "Le format n'est pas bon"
                error.style.color = "red"
            }else{
                error.textContent = "Le format est bon"
                error.style.color = "green"
            }
        });
    });

</script>
</body>
</html>
