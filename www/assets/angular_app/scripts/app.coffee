window.logged_in_user = null
'use strict'
angular.module('subzapp_mobile', [
    'ngAnimate'
    'ui.router'
    'ngRoute'
])

angular.module('subzapp_mobile').constant('API', 'api/v1/')

angular.module('subzapp_mobile').config ($stateProvider, $urlRouterProvider) ->

  $urlRouterProvider.otherwise "/"  
  # login state
  $stateProvider.state "login",
    url : "/"
    templateUrl : 'assets/angular_app/views/login/login.html'
    controller : "LoginController"


angular.module('subzapp_mobile').constant 'RESOURCES', do ->
  # Define your variable
  console.log "url " + window.location.origin 
  url = window.location.origin 
  # Use the variable in your constants
  {
    DOMAIN: url
    # USERS_API: resource + '/users'
    # BASIC_INFO: resource + '/api/info'
  }


angular.module('subzapp_mobile').factory 'message', ->
  { error: (mes) ->
    $('.login_error').text mes
    $('.login_error').show 'slide', { direction: 'right' }, 1000
    # alert "This is an error #{ mes }"
    # return
 }

 angular.module('subzapp_mobile').service 'user', ($http, $state, RESOURCES ) ->
  console.log "user service"
  {
    get_user: ->
      
      console.log "yyyyyyyyyyyyyyyyyyy"
      user_token = window.localStorage.getItem 'user_token'
      id = window.localStorage.getItem 'user_id'

      # console.log " token #{ user_token }"
      # console.log "id #{ id }"
      $http(
        method: 'GET'
        url: "#{ RESOURCES.DOMAIN }/user/#{ id }"
        headers: { 'Authorization': "JWT #{ user_token }", "Content-Type": "application/json" }
      ).success( (data) ->
        console.log "Fetched user data #{ JSON.stringify data }"
        if !(data?)
          $state.go 'login'
          console.log "No user data"
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