// Generated by CoffeeScript 1.10.0
window.myApp.controller('users_controller', function($scope, $http, $location, RESOURCES) {
  var user_object;
  user_object = JSON.parse(window.localStorage.getItem('user_jwt'));
  return $http({
    method: 'GET',
    url: RESOURCES.DOMAIN + "/user/1",
    headers: {
      'Authorization': "JWT " + user_object.token,
      "Content-Type": "application/json"
    }
  }).success(function(data) {
    if (data[0].email == null) {
      Scope.path('/');
    } else {
      if (user_object.user.email !== data[0].email) {
        console.log(user_object.user.email + " " + data[0].email);
      } else {
        console.log('yep');
      }
    }
    $scope.user = data[0];
    return console.log("Returned user from server " + (JSON.stringify(data[0])));
  }).error(function(err) {
    $location.path('/');
    return console.log("Error " + (JSON.stringify(err)));
  });
});