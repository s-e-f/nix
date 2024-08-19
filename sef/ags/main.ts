import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const Bar = (monitor: number) =>
	Widget.Window({
		name: `bar-${monitor}`,
		child: Widget.Label("hello"),
	});

App.config({
	windows: [Bar(0)],
});
