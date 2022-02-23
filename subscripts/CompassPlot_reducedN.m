
function [F1,F2]= CompassPlot_reducedN(cond_ON, cond_OFF,con_name, Average)


Z_cond_ON= cond_ON.Z; 
Z_cond_OFF= cond_OFF.Z; 

theta=[90, 45, 0, 315, 270, 225, 180, 130, 90];
onedeg=2*pi/360; %in rad 
theta=theta*onedeg;

R_teta=[1,0,0,0,0,0,0,0];
L=sum(R_teta.*exp(1i*theta(1:end-1)))/sum(R_teta);

if ~ Average
    Z=Z_cond_ON;

    %Bright Stripe - T4 
    F1=figure ;
    subplot(2,1,1)
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    T4A=Z.T4A.ALL; 
    Comp=compass(T4A);
    for i=1:length(Comp)
        set(Comp(i),'color',[0 .5 0]);
    end  
    Comp=compass(mean(T4A),'k');


%     subplot(2,2,2);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on  
    T4B=Z.T4B.ALL;
    Comp=compass(T4B, 'b');
    for i=1:length(Comp)
        set(Comp(i),'color',[0 0 1]);
    end
    Comp=compass(mean(T4B),'k');


%     subplot(2,2,3);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on  
    T4C=Z.T4C.ALL;
    Comp=compass(T4C);
    for i=1:length(Comp)
        set(Comp(i),'color',[1 0 0]);
    end 
    Comp=compass(mean(T4C),'k');


%     subplot(2,2,4);
    P=compass(L);set(P, 'Visible', 'off');hold on 
    T4D=Z.T4D.ALL;
    Comp=compass(T4D);
    for i=1:length(Comp)
        set(Comp(i),'color', [.7 .7 0]);
    end 
    Comp=compass(mean(T4D),'k');
    title([con_name,'  T4: LayerA - N Cells= ',num2str(length(T4A)),  '  LayerB - N Cells= ',num2str(length(T4B)),...
    '  LayerC - N Cells= ',num2str(length(T4C)),'  LayerD - N Cells= ',num2str(length(T4D))]);




    %Dark Stripe - T5 
    Z=Z_cond_OFF;
    
    subplot(2,1,2)
    P=compass(L); set(P, 'Visible', 'off');hold on ;
    T5A=Z.T5A.ALL;
    Comp=compass(T5A);
    for i=1:length(Comp)
        set(Comp(i),'color',[0 .5 0]);
    end  
    Comp=compass(mean(T5A),'k');

%     subplot(2,2,2);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    T5B=Z.T5B.ALL;
    Comp=compass(T5B, 'b');
    for i=1:length(Comp)
        set(Comp(i),'color',[0 0 1]);
    end
    Comp=compass(mean(T5B),'k');


%     subplot(2,2,3);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    T5C=Z.T5C.ALL;
    Comp=compass(T5C);
    for i=1:length(Comp)
        set(Comp(i),'color',[1 0 0]);
    end 
    Comp=compass(mean(T5C),'k');


%     subplot(2,2,4);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    T5D=Z.T5D.ALL;
    Comp=compass(T5D);
    for i=1:length(Comp)
        set(Comp(i),'color', [.7 .7 0]);
    end 
    Comp=compass(mean(T5D),'k');
    
    title([con_name,'  T5: LayerA - N Cells= ',num2str(length(T5A)),  '  LayerB - N Cells= ',num2str(length(T5B)),...
    '  LayerC - N Cells= ',num2str(length(T5C)),'  LayerD - N Cells= ',num2str(length(T5D))]);



elseif Average
    
    Z=Z_cond_ON;

    %Bright Stripe - T4 
    F1=figure ;
    subplot(1,2,2)
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 

    Comp=compass(Z.T4A.M);
    for i=1:length(Comp)
        set(Comp(i),'color',[0 .5 0]);
    end  
%     Comp=compass(mean(Z.T4A.M),'k');
%     title([con_name,'  T4: N Flies= ',num2str(length(Z.T4A.M))]);
    title([con_name,'  T4:']);

%     subplot(2,2,2);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    Comp=compass(Z.T4B.M, 'b');
    for i=1:length(Comp)
        set(Comp(i),'color',[0 0 1]);
    end
%     Comp=compass(mean(Z.T4B.M),'k');
%     title(['LayerB - N Flies= ',num2str(length(Z.T4B.M))]);


%     subplot(2,2,3);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    Comp=compass(Z.T4C.M);
    for i=1:length(Comp);
        set(Comp(i),'color',[1 0 0]);
    end 
%     Comp=compass(mean(Z.T4C.M),'k');
%     title(['LayerC - N Flies= ',num2str(length(Z.T4C.M))]);


%     subplot(2,2,4);
    P=compass(L);set(P, 'Visible', 'off');hold on 
    Comp=compass(Z.T4D.M);
    for i=1:length(Comp);
        set(Comp(i),'color', [.7 .7 0]);
    end 
%     Comp=compass(mean(Z.T4D.M),'k');
%     title(['LayerD - N Flies= ',num2str(length(Z.T4D.M))]);



    %Dark Stripe - T5 
    Z=Z_cond_OFF;
%     F2=figure;
    subplot(1,2,1)
    P=compass(L); set(P, 'Visible', 'off');hold on ;
    Comp=compass(Z.T5A.M);
    for i=1:length(Comp)
        set(Comp(i),'color',[0 .5 0]);
    end  
%     Comp=compass(mean(Z.T5A.M),'k');
    title([con_name,' N Flies= ',num2str(length(Z.T5A.M)), '   T5:']);

%     subplot(2,2,2);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    Comp=compass(Z.T5B.M, 'b');
    for i=1:length(Comp)
        set(Comp(i),'color',[0 0 1]);
    end
%     Comp=compass(mean(Z.T5B.M),'k');
%     title(['LayerB - N Flies= ',num2str(length(Z.T5B.M))]);


%     subplot(2,2,3);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    Comp=compass(Z.T5C.M);
    for i=1:length(Comp);
        set(Comp(i),'color',[1 0 0]);
    end 
%     Comp=compass(mean(Z.T5C.M),'k');
%     title(['LayerC - N Flies= ',num2str(length(Z.T5C.M))]);


%     subplot(2,2,4);
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on 
    Comp=compass(Z.T5D.M);
    for i=1:length(Comp);
        set(Comp(i),'color', [.7 .7 0]);
    end 
%     Comp=compass(mean(Z.T5D.M),'k');
%     title(['LayerD - N Flies= ',num2str(length(Z.T5D.M))]);
    
     F2=figure;
  
end 