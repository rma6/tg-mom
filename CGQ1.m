function CVAL = CGQ1(CF,XL,XU,N)

NQ = [2, 4, 8, 10, 12, 16, 24, 32];
NS = [1, 3, 7, 15, 25, 37, 53, 77];
QG = [.288675134594812882E0, 0.5E0, .43056815579702629E0, .17392742256872693E0, .16999052179242813E0, .32607257743127307E0, 0.48014492824876812E0, .50614268145188130E-1, .39833323870681337E0, .11119051722668724E0, .26276620495816449E0, .15685332293894364E0, .9171732124782490E-1, .18134189168918099E0, .48695326425858586E0, .3333567215434407E-1, .43253168334449225E0, .747256745752903E-1, .3397047841496122E0, .10954318125799102E0, .2166976970646236E0, .13463335915499818E0, .74437169490815605E-1, .14776211235737644E0, 0.49078031712335963E0, .23587668193255914E-1, .45205862818523743E0, .53469662997659215E-1, .38495133709715234E0, .8003916427167311E-1, .29365897714330872E0, .10158371336153296E0, .18391574949909010E0, .11674626826917740E0, .62616704255734458E-1, .12457352290670139E0, .49470046749582497E0, .13576229705877047E-1, .47228751153661629E0, .31126761969323946E-1, .43281560119391587E0, .47579255841246392E-1, .37770220417750152E0, .62314485627766936E-1, .30893812220132187E0, .7479799440828837E-1, .22900838882861369E0, .8457825969750127E-1, .14080177538962946E0, .9130170752246179E-1, .47506254918818720E-1, .9472530522753425E-1, 0.49759360999851068E+0, 0.61706148999935998E-2, 0.48736427798565475E+0, 0.14265694314466832E-1, 0.46913727600136638E+0, 0.22138719408709903E-1, 0.44320776350220052E+0, 0.29649292457718890E-1, 0.41000099298695146E+0, 0.36673240705540153E-1, 0.37006209578927718E+0, 0.43095080765976638E-1, 0.32404682596848778E+0, 0.48809326052056944E-1, 0.27271073569441977E+0, 0.53722135057982817E-1, 0.21689675381302257E+0, 0.57752834026862801E-1, 0.15752133984808169E+0, 0.60835236463901696E-1, 0.95559433736808150E-1, 0.62918728173414148E-1, 0.32028446431302813E-1, 0.63969097673376078E-1, 0.49863193092474078E+0, 0.35093050047350483E-2, 0.49280575577263417E+0, 0.81371973654528350E-2, 0.48238112779375322E+0, 0.12696032654631030E-1, 0.46745303796886984E+0, 0.17136931456510717E-1, 0.44816057788302606E+0, 0.21417949011113340E-1, 0.42468380686628499E+0, 0.25499029631188088E-1, 0.39724189798397120E+0, 0.29342046739267774E-1, 0.36609105937014484E+0, 0.32911111388180923E-1, 0.33152213346510760E+0, 0.36172897054424253E-1, 0.29385787862038116E+0, 0.39096947893535153E-1, 0.25344995446611470E+0, 0.41655962113473378E-1, 0.21067563806531767E+0, 0.43826046502201906E-1, 0.16593430114106382E+0, 0.45586939347881942E-1, 0.1196436814006854E+0, 0.46922199540402283E-1, 0.72235980791398250E-1, 0.47819360039637430E-1, 0.24153832843869158E-1, 0.48270044257363900E-1];

for L = 1:8
    if N == NQ(L)
        NP = NS(L);
        NE = NP+N-1;
        AX = 0.5*(XU+XL);
        BX = XU-XL;
        CVAL = 0;
        for J = NP:2:NE
            DX = QG(J)*BX;
            CVAL = CVAL+QG(J+1)*(CF(AX+DX)+CF(AX-DX));
        end
        CVAL = CVAL*BX;
        return
    end
end
error("Integration not possible")
end

