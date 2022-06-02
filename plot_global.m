% This script plots time series of global SST from spinup runs

addpath(genpath('/short/e14/rmh561/software/matlab-utilities/'));
startup;
bases = {['/g/data3/hh5/tmp/cosima/access-om2/1deg_jra55_ryf8485_kds50_may/'], ...
         ['/short/e14/rmh561/access-om2/archive/' ...
          '1deg_jra55_ryf8485_kds50_may_kb1em5/'], ...
         ['/g/data3/hh5/tmp/cosima/mom025/mom025_nyf/'], ...
         };

outputs = {[0:4],[0:1],[0:50],[0:50]};
suf = {'ocean/','ocean/','','ocean/'};

temps = {[],[],[],[]};
times = {[],[],[],[]};
for ii=1:length(bases)
    for jj = 1:length(outputs{ii})
        ii
        jj
        temps{ii} = [temps{ii} ncread(sprintf([bases{ii} 'output%03d/' ...
                            suf{ii} 'ocean_scalar.nc'], ...
                                              outputs{ii}(jj)),'temp_global_ave')];
    end 
end

figure;
colors = {'b','r',[0 0.5 0]};
legh = [];
for ii=1:length(bases)
    legh(ii) = plot((1:length(temps{ii}))/12,temps{ii},'-','color', ...
         colors{ii},'linewidth',1);
    hold on;
    plot((1:length(temps{ii}))/12,filter_field(temps{ii},12,'-t'),'-','color', ...
         colors{ii},'linewidth',3);
end
grid on;
xlabel('Time (years)');
ylabel('Global Average Temperature ($^\circ$C)');

text(10,3.7,'1/4$^\circ$ MOM','color',[0 0.5 0]);
text(10,3.7,'1$^\circ$ MOM','color','b');
text(10,3.7,'1$^\circ$ MOM with $\kappa_B=10^{-5}$m$^2$s$^{-1}$','color','r');



