# Redmine Banner Notifications plugin

Plugin allows admins and chosen people to create notifications, that will show as a banner to specific users.

## Requirements

Developed and tested on Redmine 3.0.7.

## Installation

1. Go to your Redmine installation's plugins/directory.
2. `git clone https://github.com/efigence/redmine_banner_notifications.git`
3. Go back to root directory.
4. `rake redmine:plugins:migrate RAILS_ENV=production`
5. Restart Redmine.

## Usage

* Admin should define which users will be allowed to create and manage banner notifications.
* Every user will see an envelope icon in the top account menu where user can see his all (also hidden) banners.
* Users that can manage banners will have Banners link on the top menu.
* Banner attributes:
  + Color of the banner depends on banner type (info - blue, warning - yellow, error - red).
  + Users will see banners between `Time from` and `Time to`.
  + If project is nil, every user can see banner (assuming other settings allows that); if project was set, banner can be seen only by users in this project.
  + If groups are empty, every user can see banner (assuming other settings allows that); if groups was set, banner can be seen only by users in this groups.
  + If `hideable` is set to true, people can click on `Close X` link to not show this banner anymore.

## License

  Redmine Banner Notifications plugin.
  Copyright (C) 2015 Efigence S.A.

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
