// Generated by CoffeeScript 1.10.0
'use strict';
angular.module('subzapp_mobile').controller('OrgController', [
  '$scope', '$state', '$http', '$window', '$location', 'message', 'user', 'RESOURCES', function($scope, $state, $http, $window, $location, message, user, RESOURCES) {
    var user_token;
    console.log("Org Controllersss");
    if (!(window.USER != null)) {
      user.get_user().then((function(res) {
        return res;
      }), function(errResponse) {
        console.log("User get error " + (JSON.stringify(errResponse)));
        window.USER = null;
        $state.go('login');
        return false;
      });
    } else {
      console.log("User already defined");
    }
    console.log("params " + JSON.stringify($location.search().id));
    user_token = window.localStorage.getItem('user_token');
    return $http({
      method: 'GET',
      url: RESOURCES.DOMAIN + "/get-single-org",
      headers: {
        'Authorization': "JWT " + user_token,
        "Content-Type": "application/json"
      },
      params: {
        org_id: $location.search().id
      }
    }).success(function(org) {
      console.log("Fetched org data " + (JSON.stringify(org)));
      $scope.teams = org.teams;
      return $scope.org = org;
    }).error(function(err) {
      return console.log("single org error " + (JSON.stringify(err)));
    });
  }
]);
