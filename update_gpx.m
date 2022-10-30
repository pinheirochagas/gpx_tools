function p = update_gpx(p)

    lat = p.Latitude;
    lon = p.Longitude;
    e = referenceEllipsoid('GRS80');
    d = distance(lat(1:end-1),lon(1:end-1),lat(2:end),lon(2:end),e);
    d = d * unitsratio('sm','meters');
    e = p.Elevation*3.28;
    p.d = cumsum(d);
    p.e = e(1:length(d));

end