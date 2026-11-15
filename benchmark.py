#!/usr/bin/env python3
"""Reproduce correctness checks, alternating trials, raw samples and medians."""
import csv, json, platform, statistics, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'results'
OUT.mkdir(exist_ok=True)
def run(version, n, repeats=1, counts=False):
    args = [str(ROOT/version), str(n), '200', str(repeats)]
    if counts: args.append('--counts')
    return json.loads(subprocess.check_output(args, text=True))
versions = ('baseline','optimized')
for version in versions:
    subprocess.run(['gcc','-std=c11','-Wall','-Wextra','-Wpedantic','-O2',str(ROOT/f'{version}.c'),'-o',str(ROOT/version),'-lm'],check=True)
    subprocess.run([str(ROOT/version),'--self-test'],check=True)
summary, raw = [], []
for n in (10000,100000,1000000):
    a,b = [run(v,n,counts=True) for v in versions]
    assert a['counts'] == b['counts'], f'per-query mismatch at {n}'
    repeats = max(1, int(.60 / min(a['search_seconds'],b['search_seconds'])) + 1)
    # Calibrate the faster implementation so both measured batches last >=0.5 s.
    while min(run(v,n,repeats)['search_seconds'] for v in versions) < .5:
        repeats *= 2
    samples = {v:[] for v in versions}
    setups = {v:[] for v in versions}
    for trial in range(-2,10):
        order = versions if trial % 2 == 0 else versions[::-1]
        pair = {}
        for v in order:
            r = run(v,n,repeats)
            pair[v] = r
            raw.append(dict(trial=trial,warmup=trial<0,**r))
            if trial >= 0:
                samples[v].append(r['search_seconds'] / (repeats*200) * 1000)
                setups[v].append(r['setup_seconds']*1000)
        assert pair['baseline']['checksum'] == pair['optimized']['checksum']
    row = dict(profiles=n,queries=200,repeats=repeats,correctness='all 200 counts identical')
    for v in versions:
        q1,_,q3 = statistics.quantiles(samples[v],n=4,method='inclusive')
        row[v+'_ms_per_query']=statistics.median(samples[v])
        row[v+'_iqr_ms']=q3-q1
        row[v+'_setup_ms']=statistics.median(setups[v])
    row['speedup']=row['baseline_ms_per_query']/row['optimized_ms_per_query']
    summary.append(row)
    (OUT/'raw_trials.json').write_text(json.dumps(raw,indent=2)+'\n')
    (OUT/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(row),flush=True)
with (OUT/'summary.csv').open('w',newline='') as f:
    w=csv.DictWriter(f,fieldnames=summary[0].keys());w.writeheader();w.writerows(summary)
env = dict(platform=platform.platform(),compiler=subprocess.check_output(['gcc','--version'],text=True).splitlines()[0],flags='-std=c11 -Wall -Wextra -Wpedantic -O2; link -lm',cpu=next((line.split(':',1)[1].strip() for line in Path('/proc/cpuinfo').read_text().splitlines() if line.startswith('model name')), 'not exposed') if Path('/proc/cpuinfo').exists() else platform.processor(),note='Shared Linux execution environment; results are machine specific. Fresh processes per batch, two warm-up batches and ten measured batches; order alternates.')
(OUT/'environment.json').write_text(json.dumps(env,indent=2)+'\n')
