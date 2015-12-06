window.logged_in_user = null
'use strict'
angular.module('subzapp_mobile', [
    'ngAnimate'
    'ui.router'
    'ngRoute'
    'angular-stripe'
])

angular.module('subzapp_mobile').constant('API', 'api/v1/')

angular.module('subzapp_mobile').config ($stateProvider, $urlRouterProvider) ->

  $urlRouterProvider.otherwise "/"  
  # login state
  $stateProvider.state "login",
    url : "/"
    templateUrl : 'assets/angular_app/views/login/login.html'
    controller : "LoginController"

  # register state
  $stateProvider.state "register",
    url : "/register"
    templateUrl : 'assets/angular_app/views/register/register.html'
    controller : "RegisterController"

  $stateProvider.state "user",
    url: "/user"
    templateUrl : 'assets/angular_app/views/user/user.html'
    controller: "UserController"

  $stateProvider.state "edit-user",
    url: "/edit-user"
    templateUrl : 'assets/angular_app/views/user/edit_user.html'
    controller: "EditUserController"

  $stateProvider.state "org",
    url: "/org"
    templateUrl : 'assets/angular_app/views/org/org.html'
    controller: "OrgController"
    
  $stateProvider.state "all_org",
    url: "/all-org"
    templateUrl : 'assets/angular_app/views/org/all-org.html'
    controller: "AllOrgController"

  $stateProvider.state "team",
    url: "/team"
    templateUrl : 'assets/angular_app/views/team/team.html'
    controller: "TeamController"

  $stateProvider.state "token",
    url: "/token"
    templateUrl : 'assets/angular_app/views/token/token.html'
    controller: "TokenController"


angular.module('subzapp_mobile').constant 'RESOURCES', do ->
  # Define your variable
  # console.log "url " + window.location.origin 
  # url = window.location.origin 
  url = "http://localhost:1337"
  # Use the variable in your constants
  {
    DOMAIN: url
    # USERS_API: resource + '/users'
    # BASIC_INFO: resource + '/api/info'
  }


angular.module('subzapp_mobile').factory 'message', ->
  error: (mes) ->
    $('.message').removeClass 'success_message'
    $('.message').addClass 'error_message'
    $('.message').text mes
    $('.message').show 'slide', { direction: 'right' }, 1000
    # alert "This is an error #{ mes }"
    # return
  success: ( mes ) ->
    $('.message').removeClass 'error_message'
    $('.message').addClass 'success_message'
    $('.message').text mes
    $('.message').show 'slide', { direction: 'right' }, 1000

    
 angular.module('subzapp_mobile').service 'user', ($http, $state, RESOURCES ) ->
  console.log "user service"
  {
    get_user: ->
      
      # console.log "yyyyyyyyyyyyyyyyyyy"
      user_token = window.localStorage.getItem 'user_token'
      id = window.localStorage.getItem 'user_id'

      # console.log " token #{ user_token }"
      # console.log "id #{ id }"
      $http(
        method: 'GET'
        url: "#{ RESOURCES.DOMAIN }/user/#{ id }"
        headers: { 'Authorization': "JWT #{ user_token }", "Content-Type": "application/json" }
      ).success( (data) ->
        # console.log "Fetched user data #{ JSON.stringify data }"
        if !(data?)
          console.log "No user data"
          $state.go 'login'
          
          return false
        else
          window.USER = data
          return data
        
      ).error (err) ->
        console.log "Fetching user data error #{ JSON.stringify err }"
        $state.go 'login'
  }


window.init = ->
  console.log "Hello"


$(document).on 'click', '#subzapp_nav', ->
  $('.subzapp_nav_collapse').collapse('hide')