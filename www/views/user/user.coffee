window.myApp.controller 'users_controller', ($scope, $http, $location, RESOURCES) ->
  user_object = JSON.parse window.localStorage.getItem 'user_jwt'
  console.log RESOURCES.DOMAIN


  $http(
    method: 'GET'
    url: "#{RESOURCES.DOMAIN}/user"
    headers: { 'Authorization': "JWT #{ user_object.data.token }", "Content-Type": "application/json" } ).success((data) ->

      console.log "Returned #{ JSON.stringify data }"
  ).error (err) ->
      $location '/'
      console.log "Error #{ JSON.stringify err }"


 
    