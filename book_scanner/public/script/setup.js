require.config({
  baseUrl: '../vendor',
  paths: {
    "app": '../script',
  },
  shim: {
    underscore: { exports: '_' },
    backbone: {
      deps: ["underscore", "jquery"],
      exports: "Backbone"
    },
    "elastislide": {
      deps: ["elastislide/jquerypp.custom", "elastislide/modernizr.custom.17475"]
    },
    "elastislide/jquerypp.custom" : {
      deps: ["jquery"]
    },
    "elastislide/modernizr.custom.17475": {
      exports: "Modernizr"
    }
  },
  packages: [
    { name: 'jquery', main: 'jquery' },
    { name: 'underscore', main: 'underscore' },
    { name: 'backbone', main: 'backbone' },
    { name: 'elastislide', main: 'jquery.elastislide' },
    {
      name: 'cs',
      location: 'require-cs',
      main: 'cs'
    },
    {
      name: 'coffee-script',
      main: 'index'
    }
  ]
});

require( [ "cs!app/app" ], function(app) {
  new app();
});
