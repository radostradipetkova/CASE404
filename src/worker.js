const CASE_ID='MP-404-017';
const json=(data,status=200)=>new Response(JSON.stringify(data),{status,headers:{'content-type':'application/json; charset=utf-8','cache-control':'no-store','x-content-type-options':'nosniff'}});
const fail=(message,status=400)=>json({error:message},status);
const clean=(v,max=80)=>typeof v==='string'?v.trim().slice(0,max):'';
const allowed={suspects:['id','name','role','age','risk','alibi','background','motive','portrait'],evidence:['id','title','category','description','source','recorded_at','unlock_key','suspect_id'],interviews:['id','suspect_id','interviewer','conducted_at','transcript'],messages:['id','channel','sender','recipient','subject','body','sent_at','unlock_key'],timeline_events:['id','event_at','title','description','unlock_key']};
async function collection(db,table,params){
 const search=clean(params.get('q'),100).toLowerCase(),filter=clean(params.get('filter'),30).toLowerCase();
 const fields=allowed[table]; if(!fields)return fail('Invalid collection');
 const searchable=table==='suspects'?['name','role','background','motive']:table==='evidence'?['title','description','source']:table==='messages'?['sender','recipient','subject','body']:table==='interviews'?['transcript']:['title','description'];
 let sql='SELECT '+fields.join(',')+' FROM '+table+' WHERE case_id = ?',bind=[CASE_ID];
 if(search){sql+=' AND ('+searchable.map(f=>'LOWER('+f+') LIKE ?').join(' OR ')+')';bind.push(...searchable.map(()=>'%'+search+'%'));}
 if(filter){const col=table==='suspects'?'risk':table==='evidence'?'category':table==='messages'?'channel':null;if(col){sql+=' AND LOWER('+col+') = ?';bind.push(filter);}else return fail('Filter not supported');}
 sql+=' ORDER BY '+(table==='suspects'||table==='evidence'?'sort_order':table==='interviews'?'conducted_at':table==='messages'?'sent_at':'event_at')+' ASC LIMIT 150';
 return json({items:(await db.prepare(sql).bind(...bind).all()).results});
}
export default {async fetch(request,env){
 const url=new URL(request.url),path=url.pathname;
 if(!path.startsWith('/api/'))return env.ASSETS.fetch(request);
 if(request.method!=='GET')return fail('This public API is read-only. Personal notes and progress are stored in your browser.',405);
 try{
  if(path==='/api/health')return json({ok:true,database:'D1',storage:'browser-local for personal data'});
  if(path==='/api/case'){const item=await env.DB.prepare('SELECT id,title,subtitle,description,status,opened_at,location,subject FROM cases WHERE id=?').bind(CASE_ID).first();return item?json({item}):fail('Case not found',404);}
  const match=path.match(/^\/api\/(suspects|evidence|interviews|messages|timeline)$/);
  if(match){const table=match[1]==='timeline'?'timeline_events':match[1];return collection(env.DB,table,url.searchParams);}
  const detail=path.match(/^\/api\/suspects\/(s[1-4])$/);
  if(detail){const item=await env.DB.prepare('SELECT id,name,role,age,risk,alibi,background,motive,portrait FROM suspects WHERE case_id=? AND id=?').bind(CASE_ID,detail[1]).first();return item?json({item}):fail('Suspect not found',404);}
  return fail('Endpoint not found',404);
 }catch(err){console.error('API error',err);return fail('Database unavailable. Run migrations and seed data.',503);}
 }};
