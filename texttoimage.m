function c = texttoimage(txt, font_size, font_name, font_type)
%TEXTTOIMAGE Rasterize text to binary images using Java, unicode is supported.
%   c = TEXTTOIMAGE(txt, font_size, font_name, font_type)
%   txt is a string to be rasterized.
%   font_size is a scalar, default 32 pixels.
%   font_name is a string, default 'Monospaced'. Note that if txt is unicode, the font specified must support it.
%   font_type is a string of comination of 'b' (bold) or 'i' (italic). Leave empty for normal typeface.
%   c is a cell array of rasterized binary images.
%
%   Example:
%   c = texttoimage('Great!', 100, 'Arial', 'ib');
%   figure; imagesc(cat(2, c{:})); axis image;

% Siyi Deng; 08-07-2016;

if nargin < 2 || isempty(font_size), font_size = 32; end
if nargin < 3 || isempty(font_name), font_name = 'Monospaced'; end
if nargin < 4 || isempty(font_type), font_type = ''; end

validateattributes(font_size, {'double'}, {'scalar', '>', 0});
validateattributes(font_name, {'char'}, {});
validateattributes(font_type, {'char'}, {});

[j, i] = ismember(lower(font_type), 'bi');
font_type = sum(i(j));

[path_file, ~, ~] = fileparts(mfilename('fullpath'));
javaaddpath(path_file);

import java.awt.Font;
r = RastFont.rasterize(Font(font_name, font_type, font_size), txt);
c = cell(numel(r), 1);
for i = 1:numel(r)
    t = r(i);
    c{i} = reshape(typecast(t(1), 'uint8'), [t(2), t(3)]).';
end
javarmpath(path_file);
end

