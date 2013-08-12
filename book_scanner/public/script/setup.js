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
    "jquery.scrollTo" : {
      deps: ["jquery"]
    },
  },
  packages: [
    { name: 'jquery', main: 'jquery' },
    { name: 'jquery.scrollTo', location: 'jquery.scrollTo', main: 'jquery.scrollTo' },
    { name: 'underscore', main: 'underscore' },
    { name: 'backbone', main: 'backbone' },
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
