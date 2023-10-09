local status, colorizer = pcall(require, "colorizer")
if not status then
	return
end

colorizer.setup{
  css = {
    rgb_fn = true;
    rgb = true;
    names = true;
  };
  html = {
    names = true;
  }
}
