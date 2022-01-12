import argparse
import subprocess


def main(
    filename: str,
    target_dir: str,
    output_dir:str,
) -> None:
    parent = '../' * target_dir.count('/')
    subprocess.run(
        [
            'latexmk',
            '-g',
            filename,
            f'-output-directory={parent}{output_dir}',
        ],
        capture_output=True,
        shell=True,
        cwd=target_dir,
    )


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--filename')
    parser.add_argument('--target-directory')
    parser.add_argument('--output-directory')
    args = parser.parse_args()

    main(
        args.filename,
        args.target_directory,
        args.output_directory
    )
