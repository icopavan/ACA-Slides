function displaySampling01()

    hFigureHandle = generateFigure(10.8,5);
    
    iStart  = 66000;
    iLength = 1024;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [xt,fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    xt      = xt/max(abs(xt));
    tt      = linspace(0,(iLength-1)/fs,iLength);

    % pretend sampling the data
    downsampleFactor = 25;
    xs      = xt(1:downsampleFactor:end);
    ts      = 1:length(xs);
    
    subplot(211)
    plot(tt,xt)
    ylabel('x(t)')
    xlabel('t [s]')
    axis([tt(1) tt(end) -1.1 1.1])
    
    subplot(212)
    stem(ts,xs,'k-','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',5);
    xlabel('i')
    ylabel('x(i)')
    axis([ts(1) length(xt)/downsampleFactor+1 -1.1 1.1])

    hold on;
    plot(linspace(ts(1), length(xt)/downsampleFactor+1, length(xt)), xt,'LineStyle','-.');
    hold off;

    printFigure(hFigureHandle, cOutputFilePath)
end