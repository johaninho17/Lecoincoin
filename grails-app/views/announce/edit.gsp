<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'announce.label', default: 'Announce')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

        <style>
            .deleteImage{
                height: 50px;
                width: 50px;
            }
        </style>
    </head>
    <body>
        <a href="#edit-announce" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
%{--        <div class="nav" role="navigation">--}%
%{--            <ul>--}%
%{--                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
%{--                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>--}%
%{--                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
%{--            </ul>--}%
%{--        </div>--}%
        <div id="edit-announce" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
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

            <g:form controller="announce" action="update" id="${announce.id}" method="POST" enctype="multipart/form-data">
                <g:hiddenField name="version" value="${this.announce?.version}" />

                <fieldset class="form">
                    <div class="fieldcontain required">
                        <label for="title">Title
                            <span class="required-indicator">*</span>
                        </label><input type="text" name="title" value="${announce.title}" required="" id="title">
                    </div>

                    <div class="fieldcontain required">
                        <label for="description">Description
                            <span class="required-indicator">*</span>
                        </label><input name="description" value="${announce.description}" required="" id="description">
                    </div>

                    <div class="fieldcontain required">
                        <label for="Price">Price
                            <span class="required-indicator">*</span>
                        </label><input name="Price" value="${announce.price}" required="" id="Price">
                    </div>

                    <div class="fieldcontain">
                        <label for="illustrations">Illustrations</label>
                        <div class="illustrationPart">
                            <g:each in="${announce.illustrations}" var="illustration">
                                <li><asset:image src="${illustration.filename}" />
                                    <g:link controller="announce" action="deleteIllustration" id="${illustration.id}">
                                        <asset:image src="delete.png" class="deleteImage"/>
                                    </g:link>
                                </li>
                            </g:each>
                            <input style="margin-top: 15px" type="file" name="payload" />
                            <span id="error"></span>
                        </div>
                    </div>

                    <div class="fieldcontain required">

                        <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_MOD">    <div class="fieldcontain required">
                            <label for="username">Author:<span class="required-indicator">*</span>
                            </label>
                            <g:select name="author.id" from="${josproject.User.list()}" optionKey="id" optionValue="username" noSelection="${[username: announce.author.username]}"></g:select>
                        %{--<g:select name="author.id" from="${userList}" optionKey="id" optionValue="username"></g:select>    </div>--}%
                        </sec:ifAnyGranted>
                        <sec:ifAnyGranted roles="ROLE_USER">    <div class="fieldcontain required">
                            <label for="username">Author:<span class="required-indicator">*</span>
                            </label>
                            <label>${announce.author.username} </label>
                       </sec:ifAnyGranted>
                    </div>
                </fieldset>

                <input id="refreshInput" type="hidden" name="refresh" value=""/>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="Save et Quitter" />
                    <input onclick="setRefreshInput();" name="create" class="save" value="Save les modifications" />
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


        function setRefreshInput()
        {
            $('#refreshInput').val('refresh');
            $('form').trigger('submit');
        }

    </script>
    </body>
</html>
