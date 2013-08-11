(function() {
  var app, _ref, _ref1, _ref2, _ref3,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  app = app || {};

  app.ScanView = (function(_super) {
    __extends(ScanView, _super);

    function ScanView() {
      _ref = ScanView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    return ScanView;

  })(Backbone.View);

  app = app || {};

  app.ProjectView = (function(_super) {
    __extends(ProjectView, _super);

    function ProjectView() {
      _ref1 = ProjectView.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    ProjectView.prototype.el = '#scan-list';

    ProjectView.prototype.events = {};

    ProjectView.prototype.initialize = function() {
      console.log('init view');
      this.collection = new app.Project();
      return this.collection.fetch({
        reset: true
      });
    };

    return ProjectView;

  })(Backbone.View);

  app = app || {};

  app.Project = (function(_super) {
    __extends(Project, _super);

    function Project() {
      _ref2 = Project.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    Project.prototype.model = app.Scan;

    return Project;

  })(Backbone.Collection);

  app = app || {};

  _.templateSettings.interpolate = /\{\{(.+?)\}\}/g;

  _.templateSettings.escape = /\{\{-(.*?)\}\}/g;

  app = app || {};

  app.Scan = (function(_super) {
    __extends(Scan, _super);

    function Scan() {
      _ref3 = Scan.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    Scan.prototype.defaults = {
      image: 'test'
    };

    return Scan;

  })(Backbone.Model);

}).call(this);
