import os
import io
import json
import urllib
import ssl
import numpy as np

def parse_cell_ids(nb_json_data):
    cell_ids = []
    for cell in nb_json_data['cells']:
        if 'metadata' in cell and 'nbgrader' in cell['metadata'] and 'grade_id' in cell['metadata']['nbgrader']:
            cell_ids.append(cell['metadata']['nbgrader']['grade_id'])
    return cell_ids

def check_notebook_uptodate_and_not_corrupted(nb_dirname, nb_fname):
    assignment_name = os.path.basename(nb_dirname)
    commit = 'master' # Should be master (latest version)
    # commit = '3d1588a79b1bd6361f6b12da9e6be022adf0f683' # For debug

    # Fetch all of these files from server. If the cell IDs of any of them matches the cell IDs of this notebook, check should succeed.
    nb_fname_candidates = ['HA2-Part1.ipynb', 'HA2-Part2.ipynb'] if os.path.basename(nb_dirname) == 'HA2' else [assignment_name+'.ipynb']

    nbr_candidate_urls = len(nb_fname_candidates)
    url_candidates = []
    for expected_nb_fname in nb_fname_candidates:
        url_candidates.append('http://raw.githubusercontent.com/JulianoLagana/deep-machine-learning/{commit}/home-assignments/{assignment_name}/{expected_nb_fname}'.format(
            assignment_name=assignment_name,
            expected_nb_fname=expected_nb_fname,
            commit=commit,
        ))
    ref_cell_id_candidates = []
    for url in url_candidates:
        try:
            # Create dummy SSL context object, to avoid issues. See https://stackoverflow.com/questions/27835619/urllib-and-ssl-certificate-verify-failed-error
            ref_nb_file = urllib.request.urlopen(url, context=ssl.SSLContext())
        except urllib.error.URLError:
            print('Failed to fetch the URL: {url}'.format(url=url))
            print('[WARNING] Could not fetch reference notebook from GitHub repo. Are you offline?')
            print('[WARNING] Could not verify that current notebook is up-to-date and not corrupted')
            return
        ref_nb_data = json.load(ref_nb_file)
        ref_cell_ids = parse_cell_ids(ref_nb_data)
        ref_cell_ids = set(ref_cell_ids)
        ref_cell_id_candidates.append(ref_cell_ids)

    with io.open(os.path.join(nb_dirname, nb_fname), mode='r', encoding='utf-8') as f:
        curr_nb_data = json.load(f)
    curr_cell_ids = parse_cell_ids(curr_nb_data)
    assert len(curr_cell_ids) == len(set(curr_cell_ids)), \
        '[ERROR] Notebook appears to be corrupt - detected multiple cells with same cell ID. Did you copy/paste any cells?'
    curr_cell_ids = set(curr_cell_ids)

    # Determine URL, by seeing which matches most cell IDs
    nbr_matching_cells = [len(curr_cell_ids & ref_cell_ids) for ref_cell_ids in ref_cell_id_candidates]
    idx_matched_candidate = np.argmax(nbr_matching_cells)
    url = url_candidates[idx_matched_candidate]
    ref_cell_ids = ref_cell_id_candidates[idx_matched_candidate]

    print('Matching current notebook against the following URL:\n{url}'.format(url=url))

    assert len(curr_cell_ids) > 0, \
        '[ERROR] Notebook appears to be corrupt - no cell IDs found. Did you perhaps run it on Google Colab?'
    if len(ref_cell_ids - curr_cell_ids) > 0:
        print('Missing cells: {}'.format(sorted(ref_cell_ids - curr_cell_ids)))
    if len(curr_cell_ids - ref_cell_ids) > 0:
        print('Found unexpected cells: {}'.format(sorted(curr_cell_ids - ref_cell_ids)))
    assert ref_cell_ids == curr_cell_ids, \
        '[ERROR] Notebook does not seem to be up-to-date. Please follow these instructions to sync with latest GitHub version: https://github.com/JulianoLagana/deep-machine-learning/blob/master/instructions/YY_keep_git_repo_in_sync.md'

    print('[SUCCESS] No major notebook mismatch found when comparing to latest GitHub version. (There might be minor updates, but even that is the case, submitting your work based on this notebook version would be acceptable.)')
