function sifts = get_sifts(face)

% face - a cell with an rgb cropped image

I = rgb2gray(cell2mat(face));
I = single(I);

sifts = extract_sifts({I});
