window.logged_in_user = null

window.myApp = angular.module('myApp', ['ngRoute', 'ngAnimate'])
myApp.config ($routeProvider) ->
  $routeProvider.when('/',
    controller: 'login_controller'
    templateUrl: 'views/login.html').when('/register',
    controller: 'register_controller',
    templateUrl: 'views/register.html')


angular.module('myApp.controllers', [])


myApp.constant 'RESOURCES', do ->
  # Define your variable
  url = 'http://localhost:1337'
  # Use the variable in your constants
  {
    DOMAIN: url
    # USERS_API: resource + '/users'
    # BASIC_INFO: resource + '/api/info'
  }

myApp.controller 'login_controller', ($scope, $http, $location, RESOURCES) ->
  $scope.user = {}
  console.log 'RESOURCES.DOMAIN ' + RESOURCES.DOMAIN
  $scope.login_submit = ->
    alert 'b'
    $http.post("#{RESOURCES.DOMAIN}/auth/signin", $scope.login_form_data).success((data) ->

      $location.path '/register'
      $scope.login_form_data = {}
      $scope.returned = data
      logged_in_user = data
      console.log "user " + JSON.stringify logged_in_user
      return
    ).error (err) ->
      $scope.errorMessage = err
      return
    return

myApp.controller 'register_controller', ($scope, $http, $location, RESOURCES) ->
  $scope.user = {}
  console.log 'register controller'
  console.log 'RESOURCES.DOMAIN ' + RESOURCES.DOMAIN
  $scope.register_submit = ->
    alert 'c'
    $http.post("#{RESOURCES.DOMAIN}/auth/signup", $scope.register_form_data).success((data) ->

      $location.path '/register'
      $scope.register_form_data = {}
      $scope.returned = data
      logged_in_user = data
      console.log "user " + JSON.stringify logged_in_user
      return
    ).error (err) ->
      $scope.errorMessage = err
      return
    return




  # init()
  # return
$(document).ready ->

  


  


  #
  
  