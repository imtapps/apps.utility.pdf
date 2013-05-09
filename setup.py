from setuptools import setup, find_packages

setup(
    name='apps.utility.pdf',
    version='0.0.1',
    author="apps",
    author_email="webadmin@imtapps.com",
    url="https://github.com/imtapps/apps.utility.pdf",
    packages=find_packages(exclude=['apps.utility.pdf/tests*']),
    namespace_packages=["apps", "apps.utility"],
    include_package_data=True,
    install_requires=file('requirements/dist.txt').read().split("\n"),
)
