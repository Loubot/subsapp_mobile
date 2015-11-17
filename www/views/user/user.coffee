window.myApp.controller 'users_controller', ($scope, $http, $location, RESOURCES) ->
  user_object = JSON.parse window.localStorage.getItem 'user_jwt'
  # console.log 'user_object ' + JSON.stringify user_object
  
  $http(
    method: 'GET'
    url: "#{RESOURCES.DOMAIN}/user"
    headers: { 'Authorization': "JWT #{ user_object.token }", "Content-Type": "application/json" } 
  ).success((data) ->
      if !(data[0].email)?
        Scope.path '/'
      else
        if user_object.user.email != data[0].email
          console.log "#{user_object.user.email} #{data[0].email}"
        else
          console.log 'yep'
      $scope.user = data[0]
      # console.log 'user_object from local storage ' + JSON.stringify data[0]
      console.log "Returned user from server #{ JSON.stringify data[0] }"
  ).error (err) ->
      $location.path '/'
      console.log "Error #{ JSON.stringify err }"

  
  $scope.up_token = ->    
    $http(
      method: 'POST'
      url: "#{ RESOURCES.DOMAIN }/up_tokens"
      headers: { 'Authorization': "JWT #{ user_object.token }", "Content-Type": "application/json" } 
    ).success((data) ->
      console.log "Seems to work " + JSON.stringify data[0]
      $scope.user = data[0]
    ).error (err) ->
      console.log "Update error " + JSON.stringify err
      $location.path '/'
      

 
    