# ServiceNow classic `*_list.do` endpoints

Find your instance

    https://<your-instance-name>.service-now.com/<endpoint>.do

Tips:

- In Next Experience, classic list routes are often reachable via `/now/nav/ui/classic/params/target/<table>_list.do`.  
- You can add filters with `?sysparm_query=...` or export flags like `?CSV` / `?EXCEL`.

---

## Core system / security / logs

- `/sys_user_list.do` — Users [sys_user]: user records (identity, contact, etc).
- `/sys_user_group_list.do` — Groups [sys_user_group]: assignment/permission groups.
- `/sys_user_grmember_list.do` — Group membership [sys_user_grmember]: user↔group mapping.
- `/sys_user_role_list.do` — Roles [sys_user_role]: defined roles.
- `/sys_user_has_role_list.do` — User roles [sys_user_has_role]: user↔role mapping (incl. inheritance).
- `/sys_choice_list.do` — Choices [sys_choice]: choice list values (localized labels).
- `/sys_properties_list.do` — System properties [sys_properties]: instance configuration flags/values.
- `/sys_email_list.do` — Email log [sys_email]: inbound/outbound email records (mailboxes are filtered views).
- `/sys_attachment_list.do` — Attachments [sys_attachment]: attachment metadata (per record).
- `/sys_attachment_doc_list.do` — Attachment chunks [sys_attachment_doc]: binary data chunks for attachments.
- `/sys_db_object_list.do` — Tables registry [sys_db_object]: list of all tables (data dictionary).
- `/sys_security_acl_list.do` — Access controls [sys_security_acl]: record/field ACL rules.
- `/sys_security_acl_role_list.do` — ACL↔role mapping [sys_security_acl_role]: roles tied to ACLs.
- `/ecc_queue_list.do` — MID/ECC queue [ecc_queue]: integration job messages to/from MID/discovery.
- `/sys_event_list.do` — Events [sysevent]: generated events (notification & automation triggers).

## ITSM (Incident / Problem / Change / Task)

- `/incident_list.do` — Incidents [incident]: service interruption/break-fix tickets.
- `/problem_list.do` — Problems [problem]: root-cause analysis & known-error process.
- `/change_request_list.do` — Changes [change_request]: planned infrastructure/service changes.
- `/task_list.do` — Tasks [task]: generic parent table for work records.

## Service Catalog / Requests

- `/sc_request_list.do` — Requests [sc_request]: customer-facing request “order” containers.
- `/sc_req_item_list.do` — Request items [sc_req_item]: line-items within a request.
- `/sc_task_list.do` — Catalog tasks [sc_task]: fulfillment steps tied to request items.

## CMDB (Configuration items)

- `/cmdb_ci_list.do` — Configuration Items [cmdb_ci]: all CIs (base class).
- `/cmdb_ci_computer_list.do` — Computers [cmdb_ci_computer]: endpoints/servers/laptops, etc.
- `/cmdb_ci_server_list.do` — Servers [cmdb_ci_server]: server-class CIs.

## IT Asset Management (ALM / HAM/SAM)

- `/alm_asset_list.do` — Assets [alm_asset]: general, financial, contractual asset data.
- `/alm_hardware_list.do` — Hardware assets [alm_hardware]: physical device assets.
- `/alm_software_list.do` — Software entitlements/licenses (varies by SAM setup).
- `/alm_consumable_list.do` — Consumables [alm_consumable]: expendable stock.
- `/alm_entitlement_asset_list.do` — Asset entitlements [alm_entitlement_asset]: entitlement↔asset ties.
- `/alm_stockroom_list.do` — Stockrooms [alm_stockroom]: storage/warehouse locations.
- `/alm_transfer_order_list.do` — Transfer orders [alm_transfer_order]: asset moves between stockrooms.

---

## Useful query knobs (append to any list)
- `?sysparm_query=<encoded_condition>` — filter (e.g., `active%3Dtrue^assigned_to%3D<sys_id>`).
- `?sysparm_view=<view_name>` — choose a column layout/view (e.g., self-service vs agent).
- `?CSV` / `?EXCEL` — export (if your role/view allows).
